import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_tv_project/home_page/ui/assets/app_fonts.dart';

import '../../bloc/channels_bloc.dart';
import '../widgets/data_picker.dart';
import '../widgets/data_table.dart';
import '../widgets/text_field.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = '';

  void _updateText(String newText) {
    setState(() {
      _text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChannelsBloc>(context).add(
      GetChannelEvent(),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Размещение рекламы',
          style: AppFonts.w500s22.copyWith(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Введите текст объявления\nСимволов: ${_text.length}',
              style: AppFonts.w500s15.copyWith(color: Colors.black),
            ),
            TextField_widget(
              onChanged: (newText) {
                _updateText(newText);
              },
            ),
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
                  return DataTable_widget(
                    image: state.model.logo ?? '',
                    titleOfChannel: state.model.channelName ?? '',
                    price: state.model.pricePerLetter ?? 0,
                  );
                } else {
                  return const DataTable_widget(
                    image:
                        'https://denisjurin.ru/wp-content/uploads/2021/05/HgRLNqN4M4.jpg',
                    titleOfChannel: 'ntv',
                    price: 9,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}