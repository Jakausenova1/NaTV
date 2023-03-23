import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_tv_project/home_page/bloc/channels_bloc.dart';
import 'package:na_tv_project/home_page/models/channel_model.dart';

import '../assets/app_fonts.dart';
import 'data_picker_range.dart';

class DataTableWidget extends StatelessWidget {
  const DataTableWidget({
    super.key,
    required this.list,
    this.isBanner = false,
  });

  final List<ChannelModel> list;
  final bool isBanner;

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: const [
          DataColumn(
            label: Text(
              'Каналы',
              style: AppFonts.w500s15,
            ),
          ),
          DataColumn(
            label: Text(
              'Дата',
              style: AppFonts.w500s15,
            ),
          ),
          DataColumn(
            label: Text(
              'Цена',
              style: AppFonts.w500s15,
            ),
          ),
        ],
        dataRowHeight: 120,
        rows: list
            .map(
              (e) => DataRow(
                cells: [
                  DataCell(
                    Column(
                      children: [
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.network(
                              e.logo ?? '',
                              fit: BoxFit.cover,
                            )),
                        Text(e.channelName ??
                            'https://natalyland.ru/wp-content/uploads/5/2/f/52f016934bfa9e80fc546468afe3960e.jpeg'),
                      ],
                    ),
                  ),
                  DataCell(
                    SizedBox(
                        width: double.infinity,
                        child: DateRangePicker(
                          id: e.id!,
                          isBanner: isBanner,
                        )),
                  ),
                  DataCell(Text(
                      '${!isBanner ? BlocProvider.of<ChannelsBloc>(context).prices[e.id!] ?? 0 : BlocProvider.of<ChannelsBloc>(context).pricesForBanner[e.id!] ?? 0}')),
                ],
              ),
            )
            .toList());
  }
}
