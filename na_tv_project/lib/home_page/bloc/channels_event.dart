part of 'channels_bloc.dart';

@immutable
abstract class ChannelsEvent {}

class GetChannelEvent extends ChannelsEvent {}

class GetTextChanged extends ChannelsEvent {
  final String text;

  GetTextChanged(this.text);
}

class SelectDate extends ChannelsEvent {
  final DateTime dateOne, dateTwo;
  final int channelId;

  SelectDate(this.dateOne, this.dateTwo, this.channelId);
}
