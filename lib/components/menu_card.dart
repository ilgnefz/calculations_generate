import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.title,
    required this.checked,
    required this.onTap,
  });

  final String title;
  final bool checked;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 56.h,
        // decoration: BoxDecoration(
        //   color: checked ? Theme.of(context).primaryColor : Colors.transparent,
        // ),
        alignment: Alignment.center,
        child: Text(
          checked ? '$title √' : title,
          style: TextStyle(
            fontSize: 15.sp,
            color: checked ? Theme.of(context).primaryColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
