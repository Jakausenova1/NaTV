import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/channels_bloc.dart';

class DateRangePicker extends StatefulWidget {
  final int id;

  const DateRangePicker({super.key, required this.id});
  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  final _dateFormatter = DateFormat('yy-MM-dd');

  Future<void> _selectDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: _startDate ?? DateTime.now(),
      end: _endDate ?? DateTime.now().add(const Duration(days: 30)),
    );

    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
      initialDateRange: initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() {
      _startDate = newDateRange.start;
      _endDate = newDateRange.end;

      BlocProvider.of<ChannelsBloc>(context)
          .add(SelectDate(_startDate!, _endDate!, widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          ListTile(
            title: Text(_startDate == null || _endDate == null
                ? 'Выберите дату'
                : 'даты: ${_dateFormatter.format(_startDate!)} - ${_dateFormatter.format(_endDate!)}'),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _selectDateRange(context),
          ),
        ],
      ),
    );
  }
}
