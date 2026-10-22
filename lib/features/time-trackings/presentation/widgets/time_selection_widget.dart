import 'package:flutter/material.dart';
import 'package:gestor_horas/data/models/shift_time_data.dart';

class TimeSelectionWidget extends StatefulWidget {
  final ShiftTimeData shiftTimeData;

  const TimeSelectionWidget({super.key, required this.shiftTimeData});

  @override
  State<TimeSelectionWidget> createState() => _TimeSelectionWidgetState();
}

class _TimeSelectionWidgetState extends State<TimeSelectionWidget> {
  static const _labelStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
    color: Colors.grey,
  );

  Widget buildTimeDropdown(
    int value,
    int maxValue,
    bool Function(int) isEnabled,
    ValueChanged<int?> onChanged,
  ) {
    return DropdownButton<int>(
      value: value,
      onChanged: onChanged,
      items: List.generate(maxValue, (int index) {
        final enabled = isEnabled(index);

        return DropdownMenuItem(
          enabled: enabled,
          value: index,
          child: Text(
            index.toString().padLeft(2, '0'),
            style: TextStyle(color: enabled ? Colors.black : Colors.grey),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hora de entrada', style: _labelStyle),
              const SizedBox(width: 12),
              buildTimeDropdown(
                widget.shiftTimeData.startHour,
                24,
                (index) => widget.shiftTimeData.endHour >= index,
                (value) => setState(() => widget.shiftTimeData.startHour = value!),
              ),

              const SizedBox(width: 8),
              buildTimeDropdown(
                widget.shiftTimeData.startMinute,
                60,
                (index) => widget.shiftTimeData.endMinute >= index,
                (value) => setState(() => widget.shiftTimeData.startMinute = value!),
              ),
            ],
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hora de salida', style: _labelStyle),
              const SizedBox(width: 12),
              buildTimeDropdown(
                widget.shiftTimeData.endHour,
                24,
                (index) => widget.shiftTimeData.startHour <= index,
                (value) => setState(() => widget.shiftTimeData.endHour = value!),
              ),

              const SizedBox(width: 8),
              buildTimeDropdown(
                widget.shiftTimeData.endMinute,
                60,
                (index) => widget.shiftTimeData.startMinute <= index,
                (value) => setState(() => widget.shiftTimeData.endMinute = value!),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
