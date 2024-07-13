import 'package:calculations_generate/core/generate.dart';
import 'package:calculations_generate/model/calculations.dart';
import 'package:calculations_generate/provider/app.dart';
import 'package:calculations_generate/views/history/history.dart';
import 'package:calculations_generate/views/widgets/calculations_content.dart';
import 'package:calculations_generate/views/widgets/empty.dart';
import 'package:calculations_generate/views/widgets/generate_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('计算题生成'),
        leading: IconButton(
          icon: const Icon(Icons.history),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HistoryView())),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => const GenerateMenu(),
              );
            },
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          CalculationsListEntity? entity = provider.calculationsListEntity;
          if (entity == null) return const EmptyView();
          List<EquationEntity> equationList = entity.equationList;
          if (equationList.isEmpty) return const EmptyView();
          return Column(
            children: [
              if (provider.has3Digits && provider.useOperations.contains('÷'))
                Container(
                  height: 24.h,
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration:
                      BoxDecoration(color: Colors.redAccent.withOpacity(.4)),
                  alignment: Alignment.center,
                  child: Text(
                    '红色序号的算式可能有问题，请注意甄别并自行修改',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ),
              Expanded(
                child: CalculationsContent(
                  equationList: equationList,
                  has3Digits: provider.has3Digits,
                  show: provider.show,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed:
                            provider.disable ? null : () => generate(provider),
                        child: const Text('重新生成'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: provider.setShow,
                        child: Text(provider.show ? '隐藏答案' : '显示答案'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
