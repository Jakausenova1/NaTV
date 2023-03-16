import 'package:dio/dio.dart';
import 'package:na_tv_project/home_page/models/channel_model.dart';

class GetChannelRepo {
  final Dio dio;

  GetChannelRepo({required this.dio});

  Future<ChannelModel> getChannel() async {
    final response = await dio.get('api/v1/channel/list');

    return ChannelModel.fromJson(response.data);
  }
}
