import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: GoogleMapDemo(),
    debugShowCheckedModeBanner: false,
  ));
}

class GoogleMapDemo extends StatefulWidget {
  const GoogleMapDemo({Key? key}) : super(key: key);

  @override
  State<GoogleMapDemo> createState() => _GoogleMapDemoState();
}

class _GoogleMapDemoState extends State<GoogleMapDemo> {
  Completer completer = Completer();
  LatLng? currentposition;
  late Double latitude;
  late Double longitude;
  bool? service;
  GoogleMapController? controller;
  CameraPosition campos = CameraPosition(
      target: LatLng(21.237444, 72.877430), zoom: 20, tilt: 30, bearing: 20);
  BitmapDescriptor? ico;
  Set<Marker> marker = <Marker>{};

  markers() {
    Marker m1 = Marker(
        markerId: MarkerId('1'),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(21.236362767816807, 72.86183845514486),
        infoWindow: InfoWindow(title: "location1"));
    Marker m2 = Marker(
        markerId: MarkerId('2'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: LatLng(21.241828818731722, 72.87163466112412),
        infoWindow: InfoWindow(title: "location2"));
    Marker m3 = Marker(
        markerId: MarkerId('3'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(21.237444, 72.877430),
        infoWindow: InfoWindow(title: "location3"));
    Marker m4 = Marker(
        markerId: MarkerId('3'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        position: LatLng(21.23607798177773, 72.86446109866161),
        infoWindow: InfoWindow(title: "location3"));
    setState(() {
      lst = [m1, m2, m3, m4];
    });
  }

  List<Marker> lst = [];

  // getmark() async {
  //   marker.add(Marker(
  //     markerId: MarkerId('surat'),
  //     icon: await MarkerIcon.pictureAsset(
  //       assetPath: "assets/images/placeholder.png",
  //       width: 100,
  //       height: 100,
  //     ),
  //     infoWindow: InfoWindow(title: "Mota varachha", snippet: "Surat"),
  //     position: LatLng(21.237444, 72.877430),
  //   ));
  // }

  @override
  void initState() {
    markers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var position =
                await GeolocatorPlatform.instance.getCurrentPosition();
            var latitude = position.latitude;
            var longitude = position.longitude;
            LatLng data = await LatLng(latitude, longitude);
            setState(() {
              currentposition = data;
            });
          },
          child: Center(child: Icon(Icons.my_location)),
        ),
        body:
            // Center(child: Text(currentposition.toString()))
            GoogleMap(
          zoomControlsEnabled: true,
          layoutDirection: TextDirection.ltr,
          // polylines: {
          //   Polyline(
          //       polylineId: PolylineId('demo'),
          //       visible: true,
          //       color: Colors.purpleAccent,
          //       width: 5,
          //       points: [
          //         LatLng(21.237444, 72.877430),
          //         LatLng(21.238798984174437, 72.86050852301416)
          //       ])
          // },
          initialCameraPosition: campos,
          myLocationButtonEnabled: true,
          zoomGesturesEnabled: true,
          mapToolbarEnabled: true,
          mapType: MapType.normal,
          rotateGesturesEnabled: true,
          myLocationEnabled: true,
          scrollGesturesEnabled: true,
          onMapCreated: (mapcontroller) {
            completer.complete(mapcontroller);
          },
          markers: lst.map((e) => e).toSet(),
        ),
      ),
    );
  }
}
