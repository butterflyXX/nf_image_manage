import 'package:flutter/foundation.dart';

class TaskItem {
  final ValueChanged<Uint8List?> callBack;
  int length = 0;
  int partCount = 0;
  final Map<String,Uint8List> datas = {};

  TaskItem(this.callBack);

  doCallBack() {
    Uint8List? finalData;
    if (datas.isNotEmpty) {
      finalData = Uint8List(length);
      int startIndex = 0;
      for(int i = 0; i < datas.length; i++) {
        final item = datas[i.toString()]!;
        finalData.setRange(startIndex, startIndex + item.length, item);
        startIndex += item.length;
      }
    }
    callBack(finalData);
  }
}