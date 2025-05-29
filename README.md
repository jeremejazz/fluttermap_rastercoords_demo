# Non-Geographical Map example in `flutter_map`

Example of a non-geographical map application in [flutter_map](https://pub.dev/packages/flutter_map).

Uses map tiles generated in [gdal2tiles](https://gdal.org/en/stable/programs/gdal2tiles.html) and [flutter_map_rastercoords](https://pub.dev/packages/flutter_map_rastercoords) library for pixel coordinates projection.

## Getting Started

For an in tutorial on how this was made, please check this post: [Creating Custom Map from Images in Flutter](https://jereme.me/post/custom-image-map-flutter/).

Create Map Tiles using `gdal2tiles`
```sh
gdal2tiles.py --xyz -p raster -z 0-5 -w none <image> <outputdir>
```

Serve the map tiles locally
```
serve -l 8080
```


Fetch all dependencies
```sh
flutter pub get
```

Run the Project
```sh
flutter run
```