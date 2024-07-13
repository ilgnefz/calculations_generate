class CalculationsListEntity {
  DateTime time;
  List<EquationEntity> equationList;
  bool has3Digits;

  CalculationsListEntity({
    required this.time,
    required this.equationList,
    required this.has3Digits,
  });

  factory CalculationsListEntity.fromJson(Map<String, dynamic> json) =>
      CalculationsListEntity(
        time: DateTime.parse(json['time']),
        equationList: List<EquationEntity>.from(
          json['equationList'].map((e) => EquationEntity.fromJson(e)),
        ),
        has3Digits: json['has3Digits'],
      );

  Map<String, dynamic> toJson() => {
        'time': time.toString(),
        'equationList': List<dynamic>.from(equationList.map((e) => e.toJson())),
        'has3Digits': has3Digits,
      };

  @override
  String toString() {
    return 'CalculationsListEntity: {time: $time, equationList: $equationList, has3Digits: $has3Digits}';
  }
}

class EquationEntity {
  EquationEntity({
    required this.equation,
    required this.result,
    required this.remainder,
    required this.doubtful,
  });

  String equation;
  int result;
  int remainder;
  bool doubtful;

  factory EquationEntity.fromJson(Map<String, dynamic> json) => EquationEntity(
        equation: json["equation"],
        result: json["result"],
        remainder: json["remainder"],
        doubtful: json["doubtful"],
      );

  Map<String, dynamic> toJson() => {
        "equation": equation,
        "result": result,
        "remainder": remainder,
        "doubtful": doubtful,
      };

  @override
  String toString() {
    return 'EquationEntity: {equation: $equation, result: $result,remainder: $remainder, doubtful: $doubtful}';
  }
}
