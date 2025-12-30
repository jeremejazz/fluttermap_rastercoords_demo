import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_rastercoords/flutter_map_rastercoords.dart';
import 'package:flutter_map_rastercoords_example/local_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalServer server = LocalServer();
  final Future<String> urlFuture = server.start();
  runApp(RasterCoordsDemo(urlFuture: urlFuture));
}

class RasterCoordsDemo extends StatelessWidget {
  final Future<String> urlFuture;


  final rc = RasterCoords(width: 6143, height: 4600);
  RasterCoordsDemo({super.key, required this.urlFuture});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Map View')),
        body: FutureBuilder<String>(
          future: urlFuture,
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            return  FlutterMap(
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
                TileLayer(urlTemplate: "${Uri.parse(snapshot.data!).toString()}/map/{z}/{x}/{y}.png" ),
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
            );
          }
        ),
      ),
    );
  }
}
