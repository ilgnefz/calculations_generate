import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EasyRadio extends StatelessWidget {
  const EasyRadio({
    super.key,
    required this.label,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final String groupValue;
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(value: label, groupValue: groupValue, onChanged: onChanged),
        Text(label, style: TextStyle(fontSize: 15.sp)),
        SizedBox(width: 8.w),
      ],
    );
  }
}
