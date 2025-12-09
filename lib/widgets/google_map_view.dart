import 'package:flutter/material.dart';
import 'package:flutter_maps_demo/helpers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

// class _GoogleMapViewState extends State<GoogleMapView> {
//   late GoogleMapController mapController;

//   final LatLng initialPosition = const LatLng(-6.200000, 106.816666);
//   // final Set<Marker> markers = {
//   //   Marker(
//   //     markerId: MarkerId("jakarta"),
//   //     position: LatLng(-6.200000, 106.816666),
//   //     infoWindow: InfoWindow(title: "Jakarta"),
//   //   ),
//   // };
//   final List<LatLng> locations = [
//     LatLng(-6.200000, 106.816666), // Jakarta
//     LatLng(-6.914744, 107.609810), // Bandung
//     LatLng(-7.250445, 112.768845), // Surabaya
//   ];

//   late Set<Marker> markers = locations.map((latLng) {
//     return Marker(markerId: MarkerId(latLng.toString()), position: latLng);
//   }).toSet();

//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       initialCameraPosition: CameraPosition(target: initialPosition, zoom: 12),
//       markers: markers,
//       onMapCreated: (controller) => mapController = controller,
//       myLocationEnabled: true,
//       myLocationButtonEnabled: true,
//     );
//   }
// }
class _GoogleMapViewState extends State<GoogleMapView> {
  late GoogleMapController mapController;
  LatLng? _currentPos;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final pos = await determinePosition();
    setState(() {
      _currentPos = LatLng(pos!.latitude, pos.longitude);
    });

    mapController.animateCamera(CameraUpdate.newLatLng(_currentPos!));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(-6.200000, 106.816666),
        zoom: 12,
      ),
      onMapCreated: (c) => mapController = c,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onTap: (pos) => print("Tap at $pos"),
      onLongPress: (pos) => print("Long press at $pos"),
      onCameraMove: (camera) => print("Camera moving"),
      onCameraIdle: () => print("Camera stopped"),
      zoomGesturesEnabled: true,
      rotateGesturesEnabled: true,
      polylines: polylines,
    );
  }

  Set<Polyline> polylines = {
    Polyline(
      polylineId: const PolylineId("route"),
      width: 4,
      color: Colors.blue,
      points: const [
        LatLng(-6.200000, 106.816666),
        LatLng(-6.914744, 107.609810),
        LatLng(-7.250445, 112.768845),
      ],
    ),
  };

  Set<Polygon> polygons = {
    Polygon(
      polygonId: const PolygonId("area"),
      fillColor: Colors.green.withOpacity(0.3),
      strokeColor: Colors.green,
      strokeWidth: 2,
      points: const [
        LatLng(-6.18, 106.80),
        LatLng(-6.20, 106.82),
        LatLng(-6.22, 106.80),
      ],
    ),
  };

  Set<Circle> circles = {
    Circle(
      circleId: const CircleId("radius"),
      center: const LatLng(-6.200000, 106.816666),
      radius: 3000, // meters
      fillColor: Colors.red.withOpacity(0.3),
      strokeColor: Colors.red,
      strokeWidth: 2,
    ),
  };
}
