import 'package:flutter/material.dart';
import 'package:flutter_maps_demo/helpers.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapboxMapView extends StatefulWidget {
  const MapboxMapView({super.key});

  @override
  State<MapboxMapView> createState() => _MapboxMapViewState();
}

class _MapboxMapViewState extends State<MapboxMapView> {
  MapboxMap? mapboxMap;
  late PointAnnotationManager _pointAnnotationManager;

  @override
  Widget build(BuildContext context) {
    return MapWidget(
      styleUri: MapboxStyles.MAPBOX_STREETS,
      onMapCreated: (controller) async {
        mapboxMap = controller;
        // Create annotation manager
        _pointAnnotationManager = await mapboxMap!.annotations
            .createPointAnnotationManager();
        _addMapboxMarker();
        _addMultipleMarkers();
        mapboxMap!.setCamera(
          CameraOptions(
            center: Point(coordinates: Position(106.816666, -6.200000)),
            zoom: 12,
          ),
        );
        mapboxMap!.location.updateSettings(
          LocationComponentSettings(enabled: true),
        );
        _moveToUserLocation();
      },
    );
  }

  void _addMapboxMarker() async {
    await _pointAnnotationManager.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: Position(106.816666, -6.200000)),
        iconSize: 1.5,
        iconImage: "marker-icon", // must be registered first
      ),
    );
  }

  void _addMultipleMarkers() async {
    final points = [
      Position(106.816666, -6.200000), // Jakarta
      Position(107.609810, -6.914744), // Bandung
      Position(112.768845, -7.250445), // Surabaya
    ];

    for (var pos in points) {
      await _pointAnnotationManager.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: pos),
          iconImage: "marker-icon",
        ),
      );
    }
  }

  void _moveToUserLocation() async {
    final pos = await determinePosition();

    mapboxMap!.setCamera(
      CameraOptions(
        center: Point(coordinates: Position(pos!.longitude, pos!.latitude)),
        zoom: 14,
      ),
    );
  }
}
