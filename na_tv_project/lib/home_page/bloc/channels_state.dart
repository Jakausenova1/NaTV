part of 'channels_bloc.dart';

@immutable
abstract class ChannelsState {}

class ChannelsInitial extends ChannelsState {}

class ChannelsLoading extends ChannelsState {}

class ChannelsSucces extends ChannelsState {
  final ChannelModel model;

  ChannelsSucces({required this.model});
}

class ChannelsError extends ChannelsState {}
