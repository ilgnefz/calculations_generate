import 'dart:convert';
import 'dart:math';

import 'package:calculations_generate/constants/key.dart';
import 'package:calculations_generate/utils/format.dart';
import 'package:calculations_generate/utils/random_num.dart';
import 'package:calculations_generate/model/calculations.dart';
import 'package:calculations_generate/provider/app.dart';
import 'package:calculations_generate/utils/storage.dart';

void generate(AppProvider provider) {
  List<int> digit1 = provider.digit1;
  List<int> digit2 = provider.digit2;
  List<int> digit3 = provider.digit3;
  List<List<int>> digits = [digit1, digit2, digit3];
  List<EquationEntity> equationList = [];
  int count = provider.count;
  for (int i = 0; i < count; i++) {
    EquationEntity equation = generateList(provider, digits);
    equationList.add(equation);
  }
  CalculationsListEntity calculationsListEntity = CalculationsListEntity(
    time: DateTime.now(),
    equationList: equationList,
    has3Digits: provider.has3Digits,
  );
  provider.setCalculationsListEntity(calculationsListEntity);
  List<String>? history = StorageUtil.getStringList(AppKeys.history);
  if (history != null && history.isNotEmpty) {
    if (history.length > 15) history.removeLast();
    history.insert(0, json.encode(calculationsListEntity.toJson()));
    StorageUtil.setStringList(AppKeys.history, history);
  } else {
    StorageUtil.setStringList(
        AppKeys.history, [json.encode(calculationsListEntity.toJson())]);
  }
}

EquationEntity generateList(AppProvider provider, List<List<int>> digits) {
  List<int> generateNum = [];
  for (final digit in digits) {
    if (digit.isEmpty) continue;
    bool filterTens = provider.filterTens;
    // 如果 filterTens 为 true，生成的两位数是 10 的倍数就重新生成
    int num = generateFinalNumber(digit);
    while (filterTens && num < 99 && num % 10 == 0) {
      num = generateFinalNumber(digit);
    }
    generateNum.add(num);
    print('$digit--------$num');
  }
  List<String> operations = provider.useOperations;
  String equation = '';
  int result = 0;
  int remainder = 0;
  bool doubtful = false;
  String operation = listRandomValue(operations);

  if (generateNum.length == 2) {
    (equation, result, remainder) = generate2NumResult(
      generateNum[0],
      generateNum[1],
      operation,
      provider,
    );
  }
  /* 三个数时的计算方法 */
  if (generateNum.length == 3) {
    String operation2 = listRandomValue(operations);
    print('运算符：$operation    $operation2');
    int num1 = generateNum[0];
    int num2 = generateNum[1];
    int num3 = generateNum[2];
    if (operation == operation2) {
      (equation, result, remainder) =
          generate3NumResult1(num1, num2, num3, operation, provider);
      if (operation == '÷') doubtful = true;
    } else {
      (equation, result, remainder) = generate3NumResult2(
          num1, num2, num3, operation, operation2, provider);
      if (operation == '÷' || operation2 == '÷') doubtful = true;
    }
  }
  return EquationEntity(
    equation: equation,
    result: result,
    remainder: remainder,
    doubtful: doubtful,
  );
}

(String, int, int) generate2NumResult(
    int num1, int num2, String operation, AppProvider provider) {
  String equation = '';
  int result = 0;
  int remainder = 0;
  switch (operation) {
    case '+':
      equation = '$num1 + $num2';
      result = num1 + num2;
      break;
    case '-':
      if (num1 < num2) (num1, num2) = (num2, num1);
      equation = '$num1 - $num2';
      result = num1 - num2;
      break;
    case '×':
      equation = '$num1 × $num2';
      result = num1 * num2;
      break;
    case '÷':
      if (num1 < num2) (num1, num2) = (num2, num1);
      result = num1 ~/ num2;
      remainder = num1 % num2;
      if (remainder != 0 && provider.mustDivide) {
        num1 = num2 * (result + 1);
      }
      equation = '$num1 ÷ $num2';
      result = num1 ~/ num2;
      remainder = num1 % num2;
  }
  return (equation, result, remainder);
}

(String, int, int) generate3NumResult1(
    int num1, int num2, int num3, String operation, AppProvider provider) {
  String equation = '';
  int result = 0;
  int remainder = 0;
  switch (operation) {
    case '+':
      equation = '$num1 + $num2 + $num3';
      result = num1 + num2 + num3;
      break;
    case '-':
      int max3Num = [num1, num2, num3].reduce(max);
      (num1, num2, num3) = newNumList([num1, num2, num3]);
      if (num1 < num2 + num3) {
        int value = maxDigitNum(max3Num.length);
        if (value > num2 + num3) {
          num1 = Random().nextInt(value + 1) + num2 + num3;
        } else {
          int max2Num = max(num2, num3);
          if (num2 == max2Num) {
            num2 =
                Random().nextInt(num1 - max2Num) + minDigitNum(max2Num.length);
          } else {
            num3 =
                Random().nextInt(num1 - max2Num) + minDigitNum(max2Num.length);
          }
        }
      }
      equation = '$num1 - $num2 - $num3';
      result = num1 - num2 - num3;
      break;
    case '×':
      equation = '$num1 × $num2 × $num3';
      result = num1 * num2 * num3;
      break;
    case '÷':
      // bool mustDivide = provider.mustDivide;
      // int max3Num = [num1, num2, num3].reduce(max);
      // (num1, num2, num3) = newNumList([num1, num2, num3]);
      // if (num1 < num2 * num3) {
      //   int value = maxDigitNum(max3Num.length);
      //   if (value > num2 * num3) {
      //     num1 = Random().nextInt(value + 1) + num2 * num3;
      //   } else {
      //     int max2Num = max(num2, num3);
      //     if (num2 == max2Num) {
      //       num2 =
      //           Random().nextInt(num1 ~/ max2Num) + minDigitNum(max2Num.length);
      //     } else {
      //       num3 =
      //           Random().nextInt(num1 ~/ max2Num) + minDigitNum(max2Num.length);
      //     }
      //   }
      // }
      //
      // result = num1 ~/ num2 ~/ num3;
      // remainder = num1 % (num2 * num3);
      // if (remainder != 0 && mustDivide) {
      //   num1 = num2 * num3 * (result + 1);
      // }
      equation = '$num1 ÷ $num2 ÷ $num3';
      result = num1 ~/ num2 ~/ num3;
      remainder = num1 % (num2 * num3);
      break;
  }
  return (equation, result, remainder);
}

(String, int, int) generate3NumResult2(int num1, int num2, int num3,
    String operation1, String operation2, AppProvider provider) {
  String equation = '';
  int result = 0;
  int remainder = 0;
  bool useBrackets = provider.useBrackets && Random().nextBool();
  bool firstLevel1 = ['+', '-'].contains(operation1);
  bool firstLevel2 = ['+', '-'].contains(operation2);
  if (!useBrackets) {
    if (firstLevel1 && !firstLevel2) {
      result = operation2 == '×' ? num2 * num3 : num2 ~/ num3;
      if (operation2 == '÷' && num2 % num3 != 0) {
        num2 = num3 * (result + 1);
        result = num2 ~/ num3;
      }
      if (operation1 == '+') result = num1 + result;
      if (operation1 == '-') result = num1 - result;
      equation = '$num1 $operation1 $num2 $operation2 $num3';
    } else {
      int value = 0;
      if (operation1 == '+') value = num1 + num2;
      if (operation1 == '-') value = num1 - num2;
      if (operation1 == '×') value = num1 * num2; // 824 * 31
      if (operation1 == '÷') {
        value = num1 ~/ num2;
        if (num1 % num2 != 0) num1 = num2 * (value + 1);
        value = num1 ~/ num2;
      }
      if (operation2 == '+') result = value + num3;
      if (operation2 == '-') result = value - num3;
      if (operation2 == '×') {
        result = value * num3;
      }
      if (operation2 == '÷') {
        result = value ~/ num3;
        remainder = value % num3;
        // if (result % num3 != 0) {
        //   num1 = num3 * result ~/ num2;
        // }
      }
      equation = '$num1 $operation1 $num2 $operation2 $num3';
    }
  } else {
    bool mustDivide = provider.mustDivide;
    if (firstLevel1 && !firstLevel2) {
      if (operation1 == '+') {
        int value = num1 + num2;
        if (operation2 == '×') result = value * num3;
        if (operation2 == '÷') {
          result = value ~/ num3;
          remainder = value % num3;
          if (remainder != 0 && mustDivide) {
            num1 = num3 * result - num2;
            remainder = 0;
          }
        }
      }
      if (operation1 == '-') {
        if (num1 < num2) (num1, num2) = (num2, num1);
        int value = num1 - num2;
        if (operation2 == '×') result = value * num3;
        if (operation2 == '÷') {
          result = value ~/ num3;
          remainder = value % num3;
          if (remainder != 0 && mustDivide) {
            num1 = num3 * result + num2;
            remainder = 0;
          }
        }
      }
      equation = '($num1 $operation1 $num2) $operation2 $num3';
    }
    if (!firstLevel1 && !firstLevel2) {
      int value = 0;
      if (operation1 == '×') value = num1 * num2;
      if (operation1 == '÷') {
        value = num1 ~/ num2;
        if (num1 % num2 != 0) num1 = num2 * (value + 1);
        value = num1 ~/ num2;
      }
      if (operation2 == '×') result = value * num3;
      if (operation2 == '÷') {
        result = value ~/ num3;
        remainder = value % num3;
      }
      equation = '$num1 $operation1 $num2 $operation2 $num3';
    }
    if (firstLevel2) {
      int value = 0;
      if (operation2 == '-') {
        if (num2 < num3) (num2, num3) = (num3, num2);
        value = num2 - num3;
      }
      if (operation2 == '+') value = num2 + num3;
      if (operation1 == '×') result = num1 * value;
      if (operation1 == '÷') {
        result = num1 ~/ value;
        remainder = num1 % value;
        if (remainder != 0 && mustDivide) {
          num1 = value * (result + 1);
          result = num1 ~/ value;
          remainder = 0;
        }
      }
      if (operation1 == '-') result = num1 - value;
      if (operation1 == '+') result = num1 + value;
      equation = '$num1 $operation1 ($num2 $operation2 $num3)';
    }
  }
  return (equation, result, remainder);
}

(int, int, int) newNumList(List<int> numList) {
  int max3Num = numList.reduce(max);
  int index = numList.indexOf(max3Num);
  List<int> otherNum = numList..removeAt(index);
  return (max3Num, otherNum[0], otherNum[1]);
}
