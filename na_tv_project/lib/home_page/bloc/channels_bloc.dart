import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:na_tv_project/home_page/models/channel_model.dart';
import 'package:na_tv_project/home_page/repositories/get_channel_repo.dart';

part 'channels_event.dart';
part 'channels_state.dart';

class ChannelsBloc extends Bloc<ChannelsEvent, ChannelsState> {
  ChannelsBloc({required this.repo}) : super(ChannelsInitial()) {
    on<GetChannelEvent>((event, emit) async {
      emit(ChannelsLoading());
      try {
        final model = await repo.getChannel();
        ChannelsSucces(model: model);
      } catch (e) {
        emit(ChannelsError());
      }
    });
  }
  final GetChannelRepo repo;
}
