import 'package:dio/dio.dart';
import 'package:na_tv_project/home_page/models/channel_model.dart';

class GetChannelRepo {
  final Dio dio;

  GetChannelRepo({required this.dio});

  Future<List<ChannelModel>> getChannel() async {
    List<ChannelModel> listChanels = [];
    final response = await dio.get('api/v1/channel/list');
    print(response.data);
    for (var model in response.data) {
      final myModel = ChannelModel.fromJson(model);
      if (myModel.id != 1) {
        listChanels.add(myModel);
      }
    }

    return listChanels;
  }

  Future<double> get_calc(int channelId, int daysCount, String text) async {
    final response = await dio.get('api/v1/channel/calculate',
        data: {"channelId": channelId, "daysCount": daysCount, "text": text});

    return response.data["priceWithDiscount"];
  }

  Future<bool> createOrder(Map<String, dynamic> data) async {
    final response = await dio.post('api/v1/order/save', data: data);
    return response.statusCode == 200;
  }

  Future<bool> createOrderBanner(Map<String, dynamic> data) async {
    final response = await dio.post('api/v1/order/save-banner', data: data);
    return response.statusCode == 200;
  }
}
