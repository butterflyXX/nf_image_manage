import 'package:flutter/foundation.dart';
import 'package:nf_image_manage/common.dart';

class TaskItem {
  final List<ValueChanged<Uint8List?>> _callBacks = [];
  int length = 0;
  int partCount = 0;
  final Map<String,Uint8List> datas = {};
  Uint8List? fullData;

  TaskItem();

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
    datas.clear();
    fullData = finalData;
    while (_callBacks.isNotEmpty) {
      final callBack = _callBacks.removeLast();
      nfPrint("走的channel");
      callBack(finalData);
    }
  }

  void addTaskCallBack(ValueChanged<Uint8List?> callBack) {
    if (fullData != null) {
      nfPrint("走的缓存");
      callBack(fullData);
    } else {
      _callBacks.add(callBack);
    }
  }

  bool removeTaskCallBack(ValueChanged<Uint8List?> callBack) {
    return _callBacks.remove(callBack);
  }
}