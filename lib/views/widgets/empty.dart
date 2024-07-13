import 'package:calculations_generate/views/widgets/generate_button.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              '暂无任何题目\n点击右上角添加生成规则',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        GenerateButton(),
      ],
    );
  }
}
