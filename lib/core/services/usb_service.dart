import 'dart:async';
import 'dart:typed_data';
import 'package:usb_serial/usb_serial.dart';
import 'package:gpsmapiot/core/services/usb_enum.dart';

class UsbService {
  UsbPort? _port;
  final _controller = StreamController<String>.broadcast();

  Stream<String> get stream => _controller.stream;
  StreamSubscription<UsbEvent>? _usbEventSub;


  UsbService(){
    listenUsbEvents();
  }

  Future<UsbStateEnum> connect() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final devices = await UsbSerial.listDevices();
      if (devices.isEmpty) return UsbStateEnum.nodevices;

      final device = devices.first;
      _port = await device.create();
      if (_port == null) return UsbStateEnum.nousb;

      final opened = await _port!.open();
      if (!opened) return UsbStateEnum.nousb;

      await _port!.setDTR(true);
      await _port!.setRTS(true);
      await _port!.setPortParameters(
        115200,
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      );

      _port!.inputStream?.listen(
            (Uint8List data) {
          _onData(data);
        },
        onError: (e) {
          _controller.add('__USB_ERROR__');
        },
        onDone: () {
          _controller.add('__USB_DISCONNECTED__');
        },
        cancelOnError: true,
      );

      return UsbStateEnum.connected;
    } catch (e, s) {
      return UsbStateEnum.nousb;
    }
  }

  void listenUsbEvents() {
    _usbEventSub = UsbSerial.usbEventStream?.listen((event) {
      if (event.event == UsbEvent.ACTION_USB_DETACHED) {
        _controller.add('__USB_DETACHED__');
      }

      if (event.event == UsbEvent.ACTION_USB_ATTACHED) {
        _controller.add('__USB_ATTACHED__');
      }
    });
  }

  void _onData(Uint8List data) {
    if (data.isNotEmpty) {
      _controller.add(String.fromCharCodes(data));
    }
  }

  Future<void> disconnect() async {
    await _port?.close();
    await _controller.close();
  }
}
