import 'package:catch_me/model/location_channel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocationChannelState extends Equatable {
  LocationChannelState([List props = const <dynamic>[]]) : super(props);
}
class LocationLoading extends LocationChannelState {
  @override
  String toString() => "CommunicationLoading";
}
class LocationLoaded extends LocationChannelState{
  final List<LocationChannel> locationMessage;

  LocationLoaded({this.locationMessage}) :super([locationMessage]);
  @override
  String toString() => "CommunicationLoaded";
}