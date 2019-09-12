import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleScreen extends StatefulWidget {
  GoogleScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GoogleScreenState();
}

class GoogleScreenState extends State<GoogleScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) async{
//    String value=await DefaultAssetBundle.of(context)
//    .loadString('assets/googe_map_style.json');
    _controller.complete(controller);
//    controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _center,
          bearing: 50,
          tilt: 70,
          zoom: 11.0,
        ),
      ),
    );
  }
}
