import 'package:calculations_generate/core/generate.dart';
import 'package:calculations_generate/provider/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GenerateButton extends StatelessWidget {
  const GenerateButton({super.key, this.quit = false});

  final bool quit;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: ElevatedButton(
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all(
            Size(MediaQuery.of(context).size.width * .9, 36.h),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey;
            }
            if (states.contains(WidgetState.pressed)) {
              return Theme.of(context).primaryColor.withOpacity(.5);
            }
            return Theme.of(context).primaryColor;
          }),
        ),
        onPressed: provider.disable
            ? null
            : () {
                generate(provider);
                if (quit) Navigator.pop(context);
              },
        child: const Text('生成', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
