import 'dart:io';
import 'package:archive/archive.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart';

class LocalServer {

  HttpServer? _server;

  Future<String> start() async {
    final directory = await getTemporaryDirectory();
    final webDir = Directory('${directory.path}/http');

    if (!await webDir.exists()) {
      await webDir.create(recursive: true);
    }

    final bytes = await rootBundle.load('assets/map.zip');

    final archive = ZipDecoder().decodeBytes(bytes.buffer.asUint8List());

    for (final file in archive) {
      final filename = '${webDir.path}/${file.name}';
      if (file.isFile) {
        final outFile = File(filename);
        await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content as List<int>);
      } else {
        await Directory(filename).create(recursive: true);
      }
    }

    final handler = createStaticHandler(webDir.path);
    _server = await shelf_io.serve(handler, InternetAddress.loopbackIPv4, 0);
    return 'http://${_server!.address.host}:${_server!.port}';
  }
}

