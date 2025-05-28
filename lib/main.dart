import 'package:flutter/material.dart';

void main() {
  runApp(const RasterCoordsDemo());
}
class RasterCoordsDemo extends StatelessWidget {
  const RasterCoordsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Map Raster Coords Example'),),
        body: Container(
          child: const Text("Hello World!"),
        ),
      )
    );
  }
}

