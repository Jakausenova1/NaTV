part of 'channels_bloc.dart';

@immutable
abstract class ChannelsState {}

class ChannelsInitial extends ChannelsState {}

class ChannelsLoading extends ChannelsState {}

class CreateOrderSucces extends ChannelsState {}

class CreateOrderError extends ChannelsState {}

class CreateOrderSuccesBanner extends ChannelsState {}

class CreateOrderErrorBanner extends ChannelsState {}

class ChannelsSucces extends ChannelsState {
  final List<ChannelModel> model;

  ChannelsSucces({required this.model});
}

class ChannelsError extends ChannelsState {}

class TextChanging extends ChannelsState {
  final int count;

  TextChanging({required this.count});
}
