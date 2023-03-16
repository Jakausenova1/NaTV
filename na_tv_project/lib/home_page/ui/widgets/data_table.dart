import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_tv_project/home_page/bloc/channels_bloc.dart';

import '../assets/app_fonts.dart';

class DataTable_widget extends StatelessWidget {
  const DataTable_widget({
    super.key,
  });

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
                  Image.network(
                      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                  Text('ntv'),
                ],
              ),
            ),
            DataCell(
              Text('datapic'),
            ),
            DataCell(
              Text('ntv'),
            ),
          ],
        ),
      ],
    );
  }
}
