import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_tv_project/home_page/bloc/channels_bloc.dart';

import '../assets/app_fonts.dart';
import 'data_picker.dart';

class DataTable_widget extends StatelessWidget {
  const DataTable_widget({
    super.key,
    required this.image,
    required this.titleOfChannel,
    required this.price,
  });

  final String image;
  final String titleOfChannel;
  final int price;

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
      rows: [
        DataRow(
          cells: [
            DataCell(
              Row(
                children: [
                  Image.network(image),
                  Text(titleOfChannel),
                ],
              ),
            ),
            DataCell(
              MyDatePicker(),
            ),
            DataCell(
              Text('$price'),
            ),
          ],
        ),
      ],
    );
  }
}
