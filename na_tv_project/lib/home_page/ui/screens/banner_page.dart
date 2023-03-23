import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:na_tv_project/home_page/ui/assets/app_fonts.dart';

import '../../bloc/channels_bloc.dart';
import '../widgets/data_table.dart';
import '../widgets/text_field.dart';

class BannerPage extends StatefulWidget {
  BannerPage({super.key});

  @override
  State<BannerPage> createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  String _text = '';

  XFile? imageSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Загрузите файл',
              style: AppFonts.w500s22,
            ),
            ElevatedButton(
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();

                  imageSelected =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                child: Text('+')),
            imageSelected != null
                ? Image.file(
                    File(imageSelected!.path),
                    width: 100,
                    height: 100,
                  )
                : SizedBox(),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Выбор каналов:',
              style: AppFonts.w500s22.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ChannelsBloc, ChannelsState>(
              builder: (context, state) {
                if (state is ChannelsSucces) {
                  return DataTableWidget(
                    isBanner: true,
                    list: state.model,
                  );
                }

                if (BlocProvider.of<ChannelsBloc>(context).model.isNotEmpty) {
                  return DataTableWidget(
                    isBanner: true,
                    list: BlocProvider.of<ChannelsBloc>(context).model,
                  );
                }

                return Text('data');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ChannelsBloc, ChannelsState>(
              builder: (context, state) {
                return Text(
                    'Общая сумма: ${BlocProvider.of<ChannelsBloc>(context).totalSummForBanner}');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  _showMyDialog(BlocProvider.of<ChannelsBloc>(context)
                      .totalSummForBanner
                      .toString());
                },
                child: Text('разместить об-е'))
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String totalPrice) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ваша заявка принята!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('К оплате: $totalPrice'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ок'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
