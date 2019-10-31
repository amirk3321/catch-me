import 'package:catch_me/model/location_channel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocationChannelEvent extends Equatable {
  LocationChannelEvent([List props = const <dynamic>[]]) : super(props);
}

class CreateLocationChannel extends LocationChannelEvent {
  final String channelId;
  final LocationChannel locationChannel;

  CreateLocationChannel({this.channelId,this.locationChannel}) : super([channelId,locationChannel]);

  @override
  String toString() => "MessagesUpdated";
}
