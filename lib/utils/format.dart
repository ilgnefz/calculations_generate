String formatTime(DateTime time) {
  String timeStr = time.toString().substring(0, 19);
  return timeStr;
}

// 给 int 类型写一个插件方法，获取 int 类型的位数
extension IntExtension on int {
  int get length {
    return toString().length;
  }
}
