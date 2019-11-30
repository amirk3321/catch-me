import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  final LatLng location;
  final MapType mapType;

  GoogleMapWidget({Key key, this.location, this.mapType}) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController _googleMapController;
  Map<MarkerId, Marker> setMarkers = <MarkerId, Marker>{};
  Map<PolylineId, Polyline> polyline = <PolylineId, Polyline>{};
  List<LatLng> routes = [];
  List<LatLng> markers = [];

  void _onMapCreated(GoogleMapController controller) async {
    if (mounted)
      setState(() {
        _googleMapController = controller;
      });
  }

  @override
  void initState() {
    super.initState();
    _setMarker();
    print(
        'LocationDatabase ${widget.location.latitude},${widget.location.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    _setMarker();

    routes.add(widget.location);
    markers.add(widget.location);
    if (markers.isNotEmpty)

    if (routes.isNotEmpty) {
      _partnerPolyLine(routes);
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: widget.mapType,
            markers: Set.of(setMarkers.values),
            polylines: Set.of(polyline.values),
            initialCameraPosition:
                CameraPosition(zoom: 20, target: widget.location),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white.withOpacity(.8)),
              child: IconButton(
                  tooltip: "Refresh Map",
                  icon: Icon(
                    Icons.directions,
                    color: Colors.lightGreen,
                  ),
                  onPressed: () {}),
            ),
            top: 10,
            right: 20,
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white.withOpacity(.8)),
              child: IconButton(
                  tooltip: "Refresh Map",
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.black54,
                  ),
                  onPressed: () {}),
            ),
            top: 65,
            right: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.my_location),
          onPressed: () {
            _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(CameraPosition(
                target: widget.location,
                zoom: 16,
              )),
            );
          }),
    );
  }

  Future<Marker> _setMarker() async {
    var markerId = MarkerId("marker${Random.secure().nextInt(100)}");
    final Uint8List markerIcon =
        await getBytesFromAsset("assets/marker.png", 40);
    var marker = Marker(
        markerId: markerId,
        position: LatLng(widget.location.latitude, widget.location.longitude),
        infoWindow: InfoWindow(
            title: "LocationTesting",
            snippet:
                "Location ${widget.location.latitude},${widget.location.longitude}"),
        icon: BitmapDescriptor.fromBytes(markerIcon));
    setState(() {
      setMarkers[markerId] = marker;
    });
    return marker;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  _partnerPolyLine(List<LatLng> routes) {
    PolylineId _partnerPolylineId =
        PolylineId('PaitenttoHospitalRountePoint001');
    var line = Polyline(
      polylineId: _partnerPolylineId,
      consumeTapEvents: true,
      width: 6,
      color: Colors.red,
      jointType: JointType.bevel,
      points: routes,
    );
    if (mounted)
      setState(() {
        polyline[_partnerPolylineId] = line;
      });
  }
}
