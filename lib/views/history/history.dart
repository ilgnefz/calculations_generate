import 'dart:convert';

import 'package:calculations_generate/constants/key.dart';
import 'package:calculations_generate/model/calculations.dart';
import 'package:calculations_generate/provider/app.dart';
import 'package:calculations_generate/utils/format.dart';
import 'package:calculations_generate/utils/storage.dart';
import 'package:calculations_generate/views/widgets/calculations_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  List<CalculationsListEntity> calculationsList = [];

  @override
  void initState() {
    super.initState();
    List<String> history = StorageUtil.getStringList(AppKeys.history) ?? [];
    if (history.isNotEmpty) parseHistory(history);
    setState(() {});
  }

  void parseHistory(List<String> history) {
    for (final item in history) {
      CalculationsListEntity calculationsListEntity =
          CalculationsListEntity.fromJson(json.decode(item));
      calculationsList.add(calculationsListEntity);
    }
  }

  void clear() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('警告'),
              content: const Text('是否清除所有历史记录？'),
              actions: [
                TextButton(
                  onPressed: () async {
                    await StorageUtil.remove(AppKeys.history);
                    calculationsList.clear();
                    setState(() {});
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                  child: const Text('确认'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('取消'),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('历史记录'),
        actions: [
          IconButton(
            onPressed: clear,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: calculationsList.isEmpty
          ? const Center(child: Text('历史记录为空'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    primary: true,
                    itemCount: calculationsList.length,
                    itemBuilder: (context, index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 48.h,
                          alignment: Alignment.center,
                          child: Text(formatTime(calculationsList[index].time)),
                        ),
                        // Expanded(child: child),
                        CalculationsContent(
                          equationList: calculationsList[index].equationList,
                          has3Digits: calculationsList[index].has3Digits,
                          show: provider.show,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(height: 32.h),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: provider.setShow,
                    child: Text(provider.show ? '隐藏答案' : '显示答案'),
                  ),
                ),
              ],
            ),
    );
  }
}
