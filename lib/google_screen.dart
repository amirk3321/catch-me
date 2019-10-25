import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleScreen extends StatefulWidget {
  GoogleScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => GoogleScreenState();
}

class GoogleScreenState extends State<GoogleScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;

  LatLng _currentLocation;

  MapType mapType;
  bool isNormal = false;

  var _location = Location();

  @override
  void initState() {
    _location.onLocationChanged().listen((locationData) {
      setState(() {

        _currentLocation = LatLng(locationData.latitude, locationData.longitude);
        print(
            'latitude ${locationData.latitude}, longitude ${locationData.longitude}');
      });
    });
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) async {
//    _controller.complete(controller);
    setState(() {
      _googleMapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _currentLocation ==null ? Center(child: CircularProgressIndicator(),) :GoogleMap(
            onMapCreated: _onMapCreated,
            onTap: (location) {
              Marker(
                  position: LatLng(location.latitude, location.longitude),
                  markerId: MarkerId('title'));
              print('my location ${location.latitude} , ${location.longitude}');
            },
            mapType: mapType,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(zoom: 16, target: _currentLocation),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white.withOpacity(.8)
              ),
              child: IconButton(
                tooltip: "MapType",
                icon: Icon(
                  Icons.map,
                  color: Colors.black54,
                ),
                onPressed: () {
                  setState(() {
                    mapType = isNormal ? MapType.normal : MapType.satellite;
                  });
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
              target: _currentLocation,
              zoom: 16,
            )),
          );
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
