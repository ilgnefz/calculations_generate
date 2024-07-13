import 'package:calculations_generate/components/easy_checkbox.dart';
import 'package:calculations_generate/components/easy_radio.dart';
import 'package:calculations_generate/components/option_padding.dart';
import 'package:calculations_generate/provider/app.dart';
import 'package:calculations_generate/views/widgets/generate_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GenerateMenu extends StatefulWidget {
  const GenerateMenu({super.key});

  @override
  State<GenerateMenu> createState() => _GenerateMenuState();
}

class _GenerateMenuState extends State<GenerateMenu> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 48.h,
              alignment: Alignment.center,
              child: Text(
                '请选择要生成的算式条件',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            // ...provider.menus.map(
            //   (e) => MenuCard(
            //     title: e.value,
            //     checked: provider.useMenu.contains(e),
            //     onTap: () {
            //       setState(() {
            //         if (provider.useMenu.contains(e)) {
            //           provider.removeMenu(e);
            //         } else {
            //           provider.addMenu(e);
            //         }
            //       });
            //     },
            //   ),
            // ),
            OptionPadding(
              label: '数一',
              children: [
                ...provider.digits.map(
                  (e) => EasyCheckbox(
                    '$e位数',
                    checked: provider.digit1.contains(e),
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          provider.addDigit1(e);
                        } else {
                          provider.removeDigit1(e);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            OptionPadding(
              label: '数二',
              children: [
                ...provider.digits.map(
                  (e) => EasyCheckbox(
                    '$e位数',
                    checked: provider.digit2.contains(e),
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          provider.addDigit2(e);
                        } else {
                          provider.removeDigit2(e);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            OptionPadding(
              label: '数三',
              children: [
                ...provider.digits.map(
                  (e) => EasyCheckbox(
                    '$e位数',
                    checked: provider.digit3.contains(e),
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          provider.addDigit3(e);
                        } else {
                          provider.removeDigit3(e);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            OptionPadding(
              label: '符号',
              children: [
                ...provider.operations.map(
                  (e) => EasyCheckbox(
                    e,
                    checked: provider.useOperations.contains(e),
                    isOperator: true,
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          provider.addOperation(e);
                        } else {
                          provider.removeOperation(e);
                        }
                      });
                    },
                  ),
                )
              ],
            ),
            OptionPadding(
              label: '个数',
              children: [
                ...provider.counts.map(
                  (e) => EasyRadio(
                    label: '$e',
                    groupValue: provider.count.toString(),
                    onChanged: (v) {
                      setState(() {
                        provider.setCount(e);
                      });
                    },
                  ),
                )
              ],
            ),
            OptionPadding(label: '规则', children: [
              EasyCheckbox(
                '必须整除',
                checked: provider.mustDivide,
                onChanged: (v) {
                  setState(() {
                    provider.setMustDivide();
                  });
                },
              ),
              EasyCheckbox(
                '使用括号',
                checked: provider.useBrackets,
                onChanged: (v) {
                  setState(() {
                    provider.setUseBrackets();
                  });
                },
              ),
              EasyCheckbox(
                '过滤整十数',
                checked: provider.filterTens,
                onChanged: (v) {
                  setState(() {
                    provider.setFilterTens();
                  });
                },
              ),
            ]),
          ],
        ),
        const GenerateButton(quit: true),
      ],
    );
  }
}
