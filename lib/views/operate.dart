import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OperateView extends StatefulWidget {
  const OperateView({super.key});

  @override
  State<OperateView> createState() => _OperateViewState();
}

class _OperateViewState extends State<OperateView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(value: '1', groupValue: '1', onChanged: (v) {}),
                      Text('三位数乘两位数', style: TextStyle(fontSize: 16.sp)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('取消')),
                SizedBox(width: 8.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('生成'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
