import 'package:calculations_generate/constants/key.dart';
import 'package:calculations_generate/model/calculations.dart';
import 'package:calculations_generate/utils/storage.dart';
import 'package:flutter/cupertino.dart';

class AppProvider extends ChangeNotifier {
  // final List<EquationType> menus = [
  //   EquationType.oneToOne,
  //   EquationType.oneToTwo,
  //   EquationType.oneToThree,
  //   EquationType.twoToTwo,
  //   EquationType.twoToThree
  // ];
  //
  // final List<EquationType> _useMenu = [];
  // List<EquationType> get useMenu => _useMenu;
  // void addMenu(EquationType menu) {
  //   _useMenu.add(menu);
  //   notifyListeners();
  // }

  // void removeMenu(EquationType menu) {
  //   _useMenu.remove(menu);
  //   notifyListeners();
  // }

  final List<String> operations = ['+', '-', '×', '÷'];

  final List<String> _useOperations =
      StorageUtil.getStringList(AppKeys.operations) ?? [];
  List<String> get useOperations => _useOperations;
  void addOperation(String operation) {
    _useOperations.add(operation);
    StorageUtil.setStringList(AppKeys.operations, _useOperations);
    notifyListeners();
  }

  void removeOperation(String operation) {
    _useOperations.remove(operation);
    StorageUtil.setStringList(AppKeys.operations, _useOperations);
    notifyListeners();
  }

  final List<int> digits = [1, 2, 3];

  final List<int> _digit1 = StorageUtil.getIntList(AppKeys.digit1) ?? [];
  List<int> get digit1 => _digit1;
  void addDigit1(int digit) {
    _digit1.add(digit);
    StorageUtil.setIntList(AppKeys.digit1, _digit1);
    notifyListeners();
  }

  void removeDigit1(int digit) {
    _digit1.remove(digit);
    StorageUtil.setIntList(AppKeys.digit1, _digit1);
    notifyListeners();
  }

  final List<int> _digit2 = StorageUtil.getIntList(AppKeys.digit2) ?? [];
  List<int> get digit2 => _digit2;
  void addDigit2(int digit) {
    _digit2.add(digit);
    StorageUtil.setIntList(AppKeys.digit2, _digit2);
    notifyListeners();
  }

  void removeDigit2(int digit) {
    _digit2.remove(digit);
    StorageUtil.setIntList(AppKeys.digit2, _digit2);
    notifyListeners();
  }

  final List<int> _digit3 = StorageUtil.getIntList(AppKeys.digit3) ?? [];
  List<int> get digit3 => _digit3;
  void addDigit3(int digit) {
    _digit3.add(digit);
    StorageUtil.setIntList(AppKeys.digit3, _digit3);
    notifyListeners();
  }

  void removeDigit3(int digit) {
    _digit3.remove(digit);
    StorageUtil.setIntList(AppKeys.digit3, _digit3);
    notifyListeners();
  }

  final List<int> counts = [5, 10, 20, 30];

  int _count = StorageUtil.getInt(AppKeys.count) ?? 10;
  int get count => _count;
  void setCount(int count) {
    _count = count;
    StorageUtil.setInt(AppKeys.count, count);
    notifyListeners();
  }

  bool _mustDivide = StorageUtil.getBool(AppKeys.mustDivide) ?? false;
  bool get mustDivide => _mustDivide;
  void setMustDivide() {
    _mustDivide = !_mustDivide;
    StorageUtil.setBool(AppKeys.mustDivide, _mustDivide);
    notifyListeners();
  }

  bool _useBrackets = StorageUtil.getBool(AppKeys.useBrackets) ?? false;
  bool get useBrackets => _useBrackets;
  void setUseBrackets() {
    _useBrackets = !_useBrackets;
    StorageUtil.setBool(AppKeys.useBrackets, _useBrackets);
    notifyListeners();
  }

  bool _filterTens = StorageUtil.getBool(AppKeys.filterTens) ?? false;
  bool get filterTens => _filterTens;
  void setFilterTens() {
    _filterTens = !_filterTens;
    StorageUtil.setBool(AppKeys.filterTens, _filterTens);
    notifyListeners();
  }

  // bool get disable {
  //   if (digit1.isEmpty) {
  //     return digit2.isEmpty || digit3.isEmpty;
  //   }
  //   if (digit2.isEmpty) {
  //     return digit1.isEmpty || digit3.isEmpty;
  //   }
  //   if (digit3.isEmpty) {
  //     return digit1.isEmpty || digit2.isEmpty;
  //   }
  //   return false;
  // }
  bool get disable {
    List<List<int>> digits = [_digit1, _digit2, _digit3];
    int nonEmptyCount = digits.where((digit) => digit.isNotEmpty).length;
    return _useOperations.isEmpty || nonEmptyCount < 2;
  }

  final List<EquationEntity> _equations = [];
  List<EquationEntity> get equations => _equations;
  void addEquation(EquationEntity equation) {
    _equations.add(equation);
    notifyListeners();
  }

  CalculationsListEntity? _calculationsListEntity;
  CalculationsListEntity? get calculationsListEntity => _calculationsListEntity;
  void setCalculationsListEntity(CalculationsListEntity entity) {
    _calculationsListEntity = entity;
    notifyListeners();
  }

  bool _show = false;
  bool get show => _show;
  void setShow() {
    _show = !_show;
    notifyListeners();
  }

  bool get has3Digits =>
      _digit1.isNotEmpty && _digit2.isNotEmpty && _digit3.isNotEmpty;

//   设置一个收否为负数的布尔值
//   bool _noNegative = StorageUtil.getBool(AppKeys.noNegative) ?? false;
//   bool get noNegative => _noNegative;
//   void setNoNegative() {
//     _noNegative = !_noNegative;
//     StorageUtil.setBool(AppKeys.noNegative, _noNegative);
//     notifyListeners();
//   }
}
