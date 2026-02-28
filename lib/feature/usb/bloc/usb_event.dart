abstract class UsbEvent {}

class UsbConnect extends UsbEvent {}

class UsbRawDataReceived extends UsbEvent {
  final String raw;
  UsbRawDataReceived(this.raw);
}

class UsbDisconnect extends UsbEvent {}
