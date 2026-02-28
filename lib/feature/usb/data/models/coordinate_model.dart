class CoordinateModel {
  final double lat;
  final double lng;

  CoordinateModel({required this.lat, required this.lng});

  factory CoordinateModel.fromRaw(String raw) {
    // ví dụ: LAT:10.1,LNG:106.2
    final parts = raw.split(',');
    return CoordinateModel(
      lat: double.parse(parts[0].split(':')[1]),
      lng: double.parse(parts[1].split(':')[1]),
    );
  }
}
