import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:na_tv_project/home_page/models/channel_model.dart';
import 'package:na_tv_project/home_page/repositories/get_channel_repo.dart';

part 'channels_event.dart';
part 'channels_state.dart';

class ChannelsBloc extends Bloc<ChannelsEvent, ChannelsState> {
  ChannelsBloc({required this.repo}) : super(ChannelsInitial()) {
    on<GetChannelEvent>(get_channels);
    on<GetTextChanged>(text_changed);
    on<SelectDate>(selected_date);
    on<BannerPrice>(bannerPrice);
  }

  final GetChannelRepo repo;
  String text = '';
  double totalSumm = 0;
  double totalSummForBanner = 0;
  Map<int, List<DateTime>> selectedDates = {};
  Map<int, List<DateTime>> selectedDatesBanners = {};
  Map<int, double?> prices = {};
  Map<int, double?> pricesForBanner = {};
  List<ChannelModel> model = [];
  get_channels(event, emit) async {
    emit(ChannelsLoading());
    try {
      model = await repo.getChannel();
      emit(ChannelsSucces(model: model));
    } catch (e) {
      emit(ChannelsError());
      print('jjj*************************$e');
    }
  }

  text_changed(event, emit) async {
    text = event.text;
    emit(TextChanging(count: text.length));
  }

  selected_date(event, emit) async {
    selectedDates[event.channelId] = [event.dateOne, event.dateTwo];
    final dayCount = event.dateOne.difference(event.dateTwo).inDays.abs();
    try {
      final double price = await repo.get_calc(event.channelId, dayCount, text);
      prices[event.channelId] = price;
      totalSumCalc();

      emit(ChannelsSucces(model: model));
    } catch (e) {
      print(
          "error######################################################### $e");
    }
  }

  totalSumCalc() {
    totalSumm = 0;

    prices.forEach((key, value) {
      totalSumm += value ?? 0;
    });
  }

  bannerPrice(event, emit) {
    selectedDatesBanners[event.channelId] = [event.dateOne, event.dateTwo];
    final dayCount = event.dateOne.difference(event.dateTwo).inDays.abs();
    pricesForBanner[event.channelId] = dayCount * 600;
    totalSummForBanner;

    emit(ChannelsSucces(model: model));
  }

  totalSumCalcBanner() {
    totalSummForBanner = 0;

    pricesForBanner.forEach((key, value) {
      totalSummForBanner += value ?? 0;
    });
  }
}
