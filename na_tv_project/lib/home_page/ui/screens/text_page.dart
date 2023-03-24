import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_tv_project/home_page/ui/assets/app_fonts.dart';

import '../../bloc/channels_bloc.dart';
import '../widgets/data_table.dart';
import '../widgets/text_field.dart';

class TextPage extends StatefulWidget {
  TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChannelsBloc>(context).add(
      GetChannelEvent(),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ChannelsBloc, ChannelsState>(
              builder: (context, state) {
                int count = 0;
                if (state is TextChanging) {
                  count = state.count;
                }
                return Text(
                  'Введите текст объявления\nСимволов: $count',
                  style: AppFonts.w500s15.copyWith(color: Colors.black),
                );
              },
            ),
            TextFieldWidget(
              onChanged: (newText) {
                BlocProvider.of<ChannelsBloc>(context).add(
                  GetTextChanged(newText),
                );
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
                  return DataTableWidget(
                    list: state.model,

                    // image: state.model[index].logo ?? '',
                    // titleOfChannel: state.model[index].channelName ?? '',
                    // price: state.model[index].pricePerLetter ?? 0,
                  );
                }

                if (BlocProvider.of<ChannelsBloc>(context).model.isNotEmpty) {
                  return DataTableWidget(
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
                    'Общая сумма: ${BlocProvider.of<ChannelsBloc>(context).totalSumm}');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<ChannelsBloc, ChannelsState>(
              listener: (context, state) {
                if (state is CreateOrderSucces) {
                  _showMyDialog(BlocProvider.of<ChannelsBloc>(context)
                      .totalSummForBanner
                      .toString());
                } else if (state is CreateOrderError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('error')));
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ChannelsBloc>(context).add(CreateOrder());
                    },
                    child: Text('разместить об-е'));
              },
            )
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
