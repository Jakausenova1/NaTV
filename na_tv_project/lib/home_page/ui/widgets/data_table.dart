import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_tv_project/home_page/bloc/channels_bloc.dart';
import 'package:na_tv_project/home_page/models/channel_model.dart';

import '../assets/app_fonts.dart';
import 'data_picker_range.dart';

class DataTable_widget extends StatelessWidget {
  const DataTable_widget({
    super.key,
    required this.list,
    // required this.image,
    // required this.titleOfChannel,
    // required this.price,
  });

  // final String image;
  // final String titleOfChannel;
  // final double price;

  final List<ChannelModel> list;

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
              'Стоимость',
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
                    SizedBox(width: double.infinity, child: DateRangePicker()),
                  ),
                  DataCell(
                    Text(e.pricePerLetter.toString()),
                  ),
                ],
              ),
            )
            .toList());
  }
}
