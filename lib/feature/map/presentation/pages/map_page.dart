import 'package:flutter/material.dart';
import 'package:gpsmapiot/feature/map/presentation/widgets/pulsing_marker.dart';
import 'package:gpsmapiot/feature/usb/data/models/coordinate_model.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  final List<CoordinateModel> coordinates;

  const MapPage({
    super.key,
    required this.coordinates,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapController _mapController;

  List<LatLng> _points = [];
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapReady = true;
      _syncPoints(fitAll: true);
    });
  }

  @override
  void didUpdateWidget(covariant MapPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.coordinates.length != widget.coordinates.length) {
      _syncPoints(fitAll: true);
    }
  }

  void _syncPoints({bool fitAll = false}) {
    _points = widget.coordinates
        .map((e) => LatLng(e.lat, e.lng))
        .toList();

    if (_mapReady && fitAll && _points.isNotEmpty) {
      final bounds = LatLngBounds.fromPoints(_points);

      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: bounds,
          padding: const EdgeInsets.all(50),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter:
          _points.isNotEmpty ? _points.first : const LatLng(0, 0),
          initialZoom: 16,
          onMapReady: () {
            _mapReady = true;
          },
        ),
        children: [
          /// MAP TILE
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'duykr.studio',
          ),

          // /// POLYLINE (đường nối các điểm)
          // if (_points.length >= 2)
          //   PolylineLayer(
          //     polylines: [
          //       Polyline(
          //         points: _points,
          //         strokeWidth: 4,
          //         color: Colors.blue,
          //       ),
          //     ],
          //   ),

          /// MARKERS
          if (_points.isNotEmpty)
            MarkerLayer(
              markers: [
                /// Marker bản thân (tọa độ đầu tiên)
                Marker(
                  point: _points.first,
                  width: 500,
                  height: 500,
                  child: const PulsingMarker(
                    size: 200,
                    color: Colors.green,
                  ),
                ),

                /// Marker các điểm còn lại
                ..._points.skip(1).map(
                      (p) => Marker(
                    point: p,
                    width: 30,
                    height: 30,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}


