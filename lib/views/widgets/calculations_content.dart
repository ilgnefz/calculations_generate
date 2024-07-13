import 'package:calculations_generate/provider/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/calculations.dart';

class CalculationsContent extends StatelessWidget {
  const CalculationsContent({
    super.key,
    required this.equationList,
    required this.has3Digits,
    required this.show,
    this.physics,
  });

  final List<EquationEntity> equationList;
  final bool has3Digits;
  final bool show;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: physics,
        crossAxisCount: has3Digits ? 1 : 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: has3Digits ? 12 / 1 : 6 / 1,
        children: List.generate(
          equationList.length,
          (index) {
            String equation = equationList[index].equation;
            if (show) {
              equation = equationList[index].remainder == 0
                  ? '${equationList[index].equation} = ${equationList[index].result}'
                  : '${equationList[index].equation} = ${equationList[index].result}······${equationList[index].remainder}';
            }
            return RichText(
              text: TextSpan(
                text: index + 1 > 9 ? '(${index + 1})  ' : '(0${index + 1})  ',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: equationList[index].doubtful
                      ? Colors.redAccent
                      : Colors.grey,
                ),
                children: [
                  TextSpan(
                    text: equation,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
