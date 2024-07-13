import 'dart:math';

int generateFinalNumber(List<int> numbers) {
  if (numbers.length == 1) {
    int num = numbers[0];
    return generateNum(num);
  } else {
    int num = listRandomValue(numbers);
    return generateNum(num);
  }
}

int generateNum(int num) {
  switch (num) {
    case 1:
      return Random().nextInt(8) + 2;
    case 2:
      return Random().nextInt(90) + 10;
    case 3:
      return Random().nextInt(900) + 100;
    default:
      throw Exception('Unsupported single number in array');
  }
}

int maxDigitNum(int num) {
  switch (num) {
    case 1:
      return 9;
    case 2:
      return 99;
    case 3:
      return 999;
    default:
      throw Exception('Unsupported single number in array');
  }
}

int minDigitNum(int num) {
  switch (num) {
    case 1:
      return 2;
    case 2:
      return 10;
    case 3:
      return 100;
    default:
      throw Exception('Unsupported single number in array');
  }
}

T listRandomValue<T>(List<T> list) {
  return list[Random().nextInt(list.length)];
}
