import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EasyCheckbox extends StatelessWidget {
  const EasyCheckbox(
    this.label, {
    super.key,
    required this.checked,
    this.isOperator = false,
    required this.onChanged,
  });

  final String label;
  final bool checked;
  final bool isOperator;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: checked, onChanged: onChanged),
        Text(label, style: isOperator ? TextStyle(fontSize: 24.sp) : null),
        SizedBox(width: 8.w),
      ],
    );
  }
}
