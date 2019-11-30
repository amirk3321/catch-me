import 'package:catch_me/model/location_channel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocationChannelEvent extends Equatable {
  LocationChannelEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadLocation extends LocationChannelEvent {
  final String channelId;

  LoadLocation({this.channelId}) : super([channelId]);

  @override
  String toString() => "MessagesUpdated";
}
class LocationUpdated extends LocationChannelEvent{
  final List<LocationChannel> locations;
  LocationUpdated({this.locations}) :super([locations]);
   @override
     String toString() => "LocationUpdated";
}
