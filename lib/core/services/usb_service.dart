import 'dart:async';
import 'dart:typed_data';
import 'package:usb_serial/usb_serial.dart';
import 'package:gpsmapiot/core/services/usb_enum.dart';

class UsbService {
  UsbPort? _port;
  final _controller = StreamController<String>.broadcast();

  Stream<String> get stream => _controller.stream;

  Future<UsbStateEnum> connect() async {
    try {
      // 1. Đợi Android ổn định USB
      await Future.delayed(const Duration(milliseconds: 500));

      // 2. Lấy danh sách thiết bị
      final List<UsbDevice> devices = await UsbSerial.listDevices();
      print('USB devices: $devices');

      if (devices.isEmpty) {
        return UsbStateEnum.nodevices;
      }

      // 3. Tạo port
      final UsbDevice device = devices.first;
      _port = await device.create();

      if (_port == null) {
        return UsbStateEnum.nousb;
      }

      // 4. Open port
      final bool openResult = await _port!.open();
      if (!openResult) {
        print('Failed to open USB port');
        return UsbStateEnum.nousb;
      }

      // 5. Set control lines
      await _port!.setDTR(true);
      await _port!.setRTS(true);

      // 6. Set baudrate & config
      await _port!.setPortParameters(
        115200,
        UsbPort.DATABITS_8,
        UsbPort.STOPBITS_1,
        UsbPort.PARITY_NONE,
      );

      // 7. Listen data (KHÔNG close ở đây)
      _port!.inputStream?.listen(
            (Uint8List data) {
          print('RX: $data');
          _onData(data); // nếu bạn có handler riêng
        },
        onError: (e) {
          print('USB error: $e');
        },
        onDone: () {
          print('USB disconnected');
        },
      );

      return UsbStateEnum.connected;
    } catch (e, s) {
      print('USB connect exception: $e');
      print(s);
      return UsbStateEnum.nousb;
    }
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
