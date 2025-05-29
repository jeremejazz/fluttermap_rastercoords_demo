import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_rastercoords/flutter_map_rastercoords.dart';

void main() {
  runApp(RasterCoordsDemo());
}

class RasterCoordsDemo extends StatelessWidget {
  final String _defaultMapUrl =
      "http://localhost:8080/map_tiles/{z}/{x}/{y}.png";
  final String _androidMapUrl =
      "http://10.0.2.2:8080/map_tiles/{z}/{x}/{y}.png";

  /// To ensure compatibility for running in localhost
  /// on other platforms.
  ///
  /// Note that you might not be needing this
  /// if your map is already running on a remote server.
  String getMapUrl() {
    if (kIsWeb) {
      return _defaultMapUrl;
    }
    if (Platform.isAndroid) {
      return _androidMapUrl;
    }

    return _defaultMapUrl;
  }

  final rc = RasterCoords(width: 6143, height: 4600);
  RasterCoordsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Map View')),
        body: FlutterMap(
          options: MapOptions(
            // Coordinate reference system for non-geographical maps
            // this also prevents the map from repeating or wrapping.
            crs: CrsSimple(),
            initialZoom: 1,
            minZoom: 1,
            // the calculated optimal zoom based on your image dimensions
            maxZoom: rc.zoom,
            // set the center by dividing
            // the height and width of your image by 2
            initialCenter: rc.pixelToLatLng(x: rc.width / 2, y: rc.height / 2),
            cameraConstraint: CameraConstraint.containCenter(
              bounds: rc.getMaxBounds(),
            ),
          ),
          children: [
            TileLayer(urlTemplate: getMapUrl()),
            MarkerLayer(
              markers: [
                Marker(
                  // create a marker on the specified pixel coordinates
                  point: rc.pixelToLatLng(x: 5232, y: 2524),
                  width: 20,
                  height: 20,
                  child: FlutterLogo(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
