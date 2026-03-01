import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpsmapiot/core/services/usb_enum.dart';
import 'package:gpsmapiot/core/services/usb_service.dart' show UsbService;
import 'package:gpsmapiot/feature/usb/bloc/usb_event.dart';
import 'package:gpsmapiot/feature/usb/bloc/usb_state.dart';
import 'package:gpsmapiot/feature/usb/data/models/coordinate_model.dart';

class UsbBloc extends Bloc<UsbEvent, UsbState> {
  final UsbService usbService;
  StreamSubscription? _subscription;

  UsbBloc(this.usbService) : super(UsbInitial()) {
    on<UsbConnect>(_onConnect);
    on<UsbRawDataReceived>(_onRawData);
    on<UsbDisconnect>(_onDisconnect);
  }

  Future<void> _onConnect(
      UsbConnect event,
      Emitter<UsbState> emit,
      ) async {

    final result = await usbService.connect();
    //
    // if (result != UsbStateEnum.connected) {
    //   emit(UsbFailure('USB not connected'));
    //   return;
    // }

    if(result == UsbStateEnum.connected){
      emit(UsbConnected());
      Future.delayed(Duration(seconds: 1));
      emit.forEach<String>(
        usbService.stream,
        onData: (data) {
          // if (data == '__USB_DETACHED__') {
          //   return UsbFailure("disconnected");
          // }
          // if (data == '__USB_ATTACHED__') {
          // }
          return UsbDataLoaded();
        },
      );
    } else {
      emit(UsbFailure('USB not connected'));
      return;
    }
  }

  void _onRawData(
      UsbRawDataReceived event,
      Emitter<UsbState> emit,
      ) {
    try {
      final coordinate = CoordinateModel.fromRaw(event.raw);
      //emit(UsbDataLoaded(coordinate));
    } catch (_) {}
  }

  Future<void> _onDisconnect(
      UsbDisconnect event,
      Emitter<UsbState> emit,
      ) async {
    await _subscription?.cancel();
    await usbService.disconnect();
    emit(UsbInitial());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    usbService.disconnect();
    return super.close();
  }
}
