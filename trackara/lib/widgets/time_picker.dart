import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeSelector extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function(DateTime, TimeOfDay) onDateTimeChanged;

  const DateTimeSelector({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateTimeChanged,
  });

  

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) { // Compare with selectedTime, not selectedDate
      onDateTimeChanged(selectedDate, picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => selectTime(context),
            icon: const Icon(Icons.access_time),
            label: Text("Time: ${selectedTime.format(context)} "),
          ),
        ),
      ],
    );
  }
}