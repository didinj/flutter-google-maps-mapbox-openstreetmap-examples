import 'package:flutter/material.dart';
import 'package:flutter_maps_demo/widgets/google_map_view.dart';
import 'package:flutter_maps_demo/widgets/mapbox_map_view.dart';
import 'package:flutter_maps_demo/widgets/osm_map_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Flutter Maps Comparison"),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Google"),
                Tab(text: "Mapbox"),
                Tab(text: "OSM"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [GoogleMapView(), MapboxMapView(), OSMMapView()],
          ),
        ),
      ),
    );
  }
}
