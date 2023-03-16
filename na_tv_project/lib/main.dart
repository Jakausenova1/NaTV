import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_tv_project/dio_settings/dio_setting.dart';
import 'package:na_tv_project/home_page/bloc/channels_bloc.dart';
import 'package:na_tv_project/home_page/repositories/get_channel_repo.dart';
import 'home_page/ui/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => GetChannelRepo(
              dio: RepositoryProvider.of<DioSettings>(context).dio),
        ),
      ],
      child: BlocProvider(
        create: (context) => ChannelsBloc(
          repo: RepositoryProvider.of<GetChannelRepo>(context),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      ),
    );
  }
}
