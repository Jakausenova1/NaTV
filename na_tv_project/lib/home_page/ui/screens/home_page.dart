import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_tv_project/home_page/ui/assets/app_fonts.dart';

import '../../bloc/channels_bloc.dart';
import '../widgets/data_table.dart';
import '../widgets/text_field.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _text = '';

  // void _updateText(String newText) {
  //   setState(() {
  //     _text = newText;
  //   });
  // }

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
            BlocBuilder<ChannelsBloc, ChannelsState>(
              builder: (context, state) {
                return Text(
                    'hhh ${BlocProvider.of<ChannelsBloc>(context).totalSumm}');
              },
            )
          ],
        ),
      ),
    );
  }
}
