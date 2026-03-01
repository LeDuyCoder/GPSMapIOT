import 'package:gpsmapiot/feature/usb/data/models/coordinate_model.dart';

abstract class UsbState {}

class UsbInitial extends UsbState {}

class UsbConnecting extends UsbState {}

class UsbConnected extends UsbState {}

class UsbDataLoaded extends UsbState {}

class UsbFailure extends UsbState {
  final String message;
  UsbFailure(this.message);
}
