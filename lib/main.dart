import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const RasterCoordsDemo());
}

class RasterCoordsDemo extends StatelessWidget {
  const RasterCoordsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Map View')),
        body: FlutterMap(
          options: MapOptions(
            initialZoom: 5,
            initialCenter: LatLng(11.3352855, 124.3544939),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            ),
          ],
        ),
      ),
    );
  }
}
