import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_maps_demo/helpers.dart';
import 'package:latlong2/latlong.dart';

// class OSMMapView extends StatelessWidget {
//   const OSMMapView({super.key});

//   final LatLng center = const LatLng(-6.200000, 106.816666); // Jakarta

//   @override
//   Widget build(BuildContext context) {
//     final points = [
//       LatLng(-6.200000, 106.816666),
//       LatLng(-6.914744, 107.609810),
//       LatLng(-7.250445, 112.768845),
//     ];

//     return FlutterMap(
//       options: MapOptions(initialCenter: center, initialZoom: 12),
//       children: [
//         TileLayer(
//           urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//           userAgentPackageName: "com.example.flutter_maps_demo",
//         ),
//         // MarkerLayer(
//         //   markers: [
//         //     Marker(
//         //       width: 40,
//         //       height: 40,
//         //       point: LatLng(-6.200000, 106.816666),
//         //       child: const Icon(
//         //         Icons.location_pin,
//         //         color: Colors.red,
//         //         size: 40,
//         //       ),
//         //     ),
//         //   ],
//         // ),
//         MarkerLayer(
//           markers: points.map((p) {
//             return Marker(
//               width: 40,
//               height: 40,
//               point: p,
//               child: const Icon(Icons.location_on, color: Colors.blue),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }
class OSMMapView extends StatefulWidget {
  const OSMMapView({super.key});

  @override
  State<OSMMapView> createState() => _OSMMapViewState();
}

class _OSMMapViewState extends State<OSMMapView> {
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    final pos = await determinePosition();
    setState(() {
      _userLocation = LatLng(pos!.latitude, pos.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: _userLocation ?? const LatLng(-6.200000, 106.816666),
        initialZoom: 13,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "com.example.flutter_maps_demo",
        ),
        if (_userLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                width: 40,
                height: 40,
                point: _userLocation!,
                child: const Icon(Icons.my_location, color: Colors.blue),
              ),
            ],
          ),
      ],
    );
  }
}
