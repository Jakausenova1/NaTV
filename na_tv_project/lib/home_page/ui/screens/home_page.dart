import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_tv_project/home_page/ui/assets/app_fonts.dart';
import 'package:na_tv_project/home_page/ui/screens/text_page.dart';

import '../../bloc/channels_bloc.dart';
import '../widgets/data_table.dart';
import '../widgets/text_field.dart';
import 'banner_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                  icon: Text(
                'text',
                style: TextStyle(color: Colors.black),
              )),
              Tab(icon: Text('banner', style: TextStyle(color: Colors.black))),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text(
            'Размещение рекламы',
            style: AppFonts.w500s22.copyWith(color: Colors.black),
          ),
        ),
        body: TabBarView(
          children: [
            TextPage(),
            BannerPage(),
          ],
        ),
      ),
    );
  }
}
