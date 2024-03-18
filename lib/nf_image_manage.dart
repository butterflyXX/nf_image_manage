import 'package:flutter/services.dart';
import 'package:nf_image_manage/task_item.dart';

String imageName = "imageName";
String packageName = "packageName";

class NfImageManage {
  static MethodChannel channel =
      const MethodChannel("nf_native_flutter_image_manage_channel");
  Map<String, TaskItem> imageDataStream = {};
  static final NfImageManage _instance = NfImageManage._internal();

  factory NfImageManage() {
    return _instance;
  }

  NfImageManage._internal() {
    channel.setMethodCallHandler((call) {
      switch (call.method) {
        case "getFlutterImage":
          _getFlutterImage(call);
          break;
        case "nativeImage":
          _receiveNativeImage(call);
          break;
      }
      return Future.value();
    });
  }

  static getNativeImage(
    String name, {
    required ValueChanged<Uint8List?> callBack,
    String? packageName,
  }) {
    putTask(name, callBack);
    channel.invokeMethod("getNativeImage", {
      "imageName": name,
      "packageName": packageName,
    }).then((value) => print(value));
  }

  static _receiveNativeImage(MethodCall call) {
    final arg = call.arguments;
    String key = arg["id"];
    String index = arg["index"].toString();
    Uint8List subData = arg["data"];
    int length = arg["length"];
    int partCount = arg["partCount"];

    final task = _instance.imageDataStream[key];
    if (task != null) {
      task.datas[index] = subData;
      task.length = length;
      task.partCount = partCount;
      if (partCount == task.datas.length) {
        _instance.imageDataStream[key]?.doCallBack();
        removeTask(key);
      }
    }
  }

  static _getFlutterImage(MethodCall call) async {
    final name = call.arguments["imageName"]!;
    final packageName = call.arguments["packageName"] ?? "assets/images/";
    final data = await rootBundle.load(packageName + name);
    int maxLength = 1024;
    int count = (data.lengthInBytes / maxLength).ceil();
    for (int i = 0; i < count; i++) {
      final Uint8List slice = data.buffer.asUint8List();
      channel.invokeMethod('flutterImage', {
        "id": name,
        "index": i,
        "data": slice,
        "length": data.lengthInBytes,
        "partCount": count,
      });
    }
  }

  static putTask(String key, ValueChanged<Uint8List?> callBack) {
    _instance.imageDataStream[key] = TaskItem(callBack);
  }

  static removeTask(String key) {
    _instance.imageDataStream.remove(key);
  }
}
