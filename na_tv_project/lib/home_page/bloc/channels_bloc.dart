import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
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
    on<CreateOrder>(creatingOrder);
    on<CreateOrderBanner>(creatingOrderBanner);
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
    pricesForBanner[event.channelId] = dayCount * 600.0;
    print("#########################################$pricesForBanner");
    totalSumCalcBanner();

    emit(ChannelsSucces(model: model));
  }

  totalSumCalcBanner() {
    totalSummForBanner = 0;

    pricesForBanner.forEach((key, value) {
      totalSummForBanner += value ?? 0;
    });
  }

  creatingOrder(event, emit) async {
    if (text.length <= 20) {
      return;
    }
    List<Map<int, List<int>>> channels = [];
    List<int> days = [];
    selectedDates.forEach((key, value) {
      days = [];
      value.forEach((date) {
        days.add(date.difference(DateTime(1970, 1, 1, 0, 0)).inDays);
      });
      channels.add({key: days});
    });

    Map<String, dynamic> data = {
      "channels": channels,
      "clientEmail": "string",
      "clientFIO": "string",
      "clientPhone": "string",
      "text": text
    };
    try {
      if (await repo.createOrder(data)) {
        emit(CreateOrderSucces());
      } else {
        emit(CreateOrderError());
      }
    } catch (e) {
      emit(CreateOrderError());
    }
  }

  creatingOrderBanner(event, emit) async {
    List<Map<int, List<int>>> channels = [];
    List<int> days = [];
    selectedDates.forEach((key, value) {
      days = [];
      value.forEach((date) {
        days.add(date.difference(DateTime(1970, 1, 1, 0, 0)).inDays);
      });
      channels.add({key: days});
    });

    Map<String, dynamic> data = {
      "channels": channels,
      "clientEmail": "string",
      "clientFIO": "string",
      "clientPhone": "string",
      "path": 'https://4lapki.com/wp-content/uploads/2020/10/Screenshot_7-1.jpg'
    };
    try {
      if (await repo.createOrderBanner(data)) {
        emit(CreateOrderSuccesBanner());
      } else {
        emit(CreateOrderErrorBanner());
      }
    } catch (e) {
      emit(CreateOrderErrorBanner());
    }
  }
}
