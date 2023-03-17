import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateRangePicker extends StatefulWidget {
  @override
  _MyDateRangePickerState createState() => _MyDateRangePickerState();
}

class _MyDateRangePickerState extends State<MyDateRangePicker> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(_startDate == null || _endDate == null
              ? 'Выберите дату'
              : 'даты: ${_dateFormatter.format(_startDate!)} - ${_dateFormatter.format(_endDate!)}'),
          trailing: const Icon(Icons.calendar_today),
          onTap: () => _selectDateRange(context),
        ),
      ],
    );
  }
}
