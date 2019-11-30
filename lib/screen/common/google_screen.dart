import 'dart:async';
import 'package:catch_me/bloc/location_channel/bloc.dart';
import 'package:catch_me/model/location_channel.dart';
import 'package:catch_me/screen/common/alert_location_dialog.dart';
import 'package:catch_me/screen/common/google_map_widget.dart';
import 'package:catch_me/screen/common/single_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleScreen extends StatefulWidget {
  final String otherName;
  final String otherUID;
  final String uid;
  final String channelID;

  GoogleScreen(
      {Key key, this.otherName, this.otherUID, this.uid, this.channelID})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => GoogleScreenState();
}

class GoogleScreenState extends State<GoogleScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _googleMapController;

  LatLng _currentLocation;

  MapType _mapType;
  bool _isNormal = false;

  var _location = Location();

  GeoPoint _userLocationShare;

  @override
  void initState() {
    _location.onLocationChanged().listen((locationData) {
      if (mounted)
        setState(() {
          _userLocationShare =
              GeoPoint(locationData.latitude, locationData.longitude);
          _currentLocation =
              LatLng(locationData.latitude, locationData.longitude);
        });
    });
    BlocProvider.of<LocationChannelBloc>(context).dispatch(LoadLocation());
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) async {
    if (mounted)
      setState(() {
        _googleMapController = controller;
      });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.otherName} Live Stream"),
        ),
        body: BlocBuilder<LocationChannelBloc, LocationChannelState>(
          builder: (BuildContext context, LocationChannelState state) {
            if (state is LocationLoaded) {
              final locationMessage = state.locationMessage.firstWhere(
                  (location) => location.channelID == widget.channelID,
                  orElse: () => LocationChannel());

              return Stack(
                children: <Widget>[
                  _currentLocation == null
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : _buildGoogleMap(locationMessage),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white.withOpacity(.8)),
                      child: IconButton(
                        tooltip: "MapType",
                        icon: Icon(
                          Icons.map,
                          color: Colors.black54,
                        ),
                        onPressed: _changeMapType,
                      ),
                    ),
                  )
                ],
              );
            }

            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        );
  }

  Widget _buildGoogleMap(LocationChannel locationMessage) {
    bool currentUser = widget.uid == locationMessage.uid &&
        locationMessage.isLocationOtherUser == true &&
        locationMessage.otherUserUserPoints != null;
    bool otherUser = widget.otherUID == locationMessage.otherUID &&
        locationMessage.isLocationCurrentUser == true &&
        locationMessage.currentUserPoints != null;

    if (currentUser){
      print("currentUserPart");
     return GoogleMapWidget(
        location:  LatLng(locationMessage.otherUserUserPoints.latitude,locationMessage.otherUserUserPoints.longitude),
        mapType: _mapType,
      );
    }else if(otherUser){
      print("OtherUserPart");
      return GoogleMapWidget(
        location:  LatLng(locationMessage.currentUserPoints.latitude,locationMessage.currentUserPoints.longitude),
        mapType: _mapType,
      );
    }else{
      print("elseUserPart");
      return AlertLocationDialog();
    }
  }

  void _changeMapType() {
    if (mounted)
      setState(() {
        if (_isNormal == false) {
          _mapType = MapType.normal;
          _isNormal = true;
        } else {
          _mapType = MapType.satellite;
          _isNormal = false;
        }
      });
  }

}
