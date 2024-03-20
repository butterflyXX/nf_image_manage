import 'package:flutter/services.dart';
import 'package:nf_image_manage/common.dart';
import 'package:nf_image_manage/task_item.dart';

String imageName = "imageName";
String packageName = "packageName";

class NfImageManage {
  static int _maxCache = 1 << 6;
  int _cacheCount = 0;
  static const MethodChannel _channel = MethodChannel("nf_native_flutter_image_manage_channel");
  final Map<String, TaskItem> _imageDataStream = {};
  static final NfImageManage _instance = NfImageManage._internal();

  factory NfImageManage() {
    return _instance;
  }

  NfImageManage._internal() {
    _channel.setMethodCallHandler((call) {
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

  static config({int? maxCache}) {
    _maxCache = maxCache??1 << 6;
  }

  static TaskItem getNativeImage(
    String name, {
    required ValueChanged<Uint8List?> callBack,
    String? packageName,
    double? compression,
  }) {
    TaskItem? task = doCache(name, callBack: callBack);
    if (task == null) {
      task = putTask(name, callBack);
      _channel.invokeMethod("getNativeImage", {
        "imageName": name,
        "packageName": packageName,
        "compression": compression ?? 1.0,
      });
    }
    return task;
  }

  static _receiveNativeImage(MethodCall call) {
    final arg = call.arguments;
    String key = arg["id"];
    String index = arg["index"].toString();
    Uint8List subData = arg["data"];
    int length = arg["length"];
    int partCount = arg["partCount"];

    final task = _instance._imageDataStream[key];
    if (task != null) {
      task.datas[index] = subData;
      task.length = length;
      task.partCount = partCount;
      if (partCount == task.datas.length) {
        _instance._imageDataStream[key]?.doCallBack();
        _instance._cacheCount++;
        nfPrint("缓存数量${_instance._cacheCount}");
        if (_instance._cacheCount >= _maxCache) {
          checkCache();
        }
      }
    }
  }

  static _getFlutterImage(MethodCall call) async {
    final name = call.arguments["imageName"]!;
    final packageName = call.arguments["packageName"] ?? "assets/images/";
    final data = await rootBundle.load(packageName + name);
    int maxLength = 1024 * 1024 << 2;
    int count = (data.lengthInBytes / maxLength).ceil();
    for (int i = 0; i < count; i++) {
      final Uint8List slice = data.buffer.asUint8List();
      _channel.invokeMethod('flutterImage', {
        "id": name,
        "index": i,
        "data": slice,
        "length": data.lengthInBytes,
        "partCount": count,
      });
    }
  }

  /// 缓存检查,如果有直接执行
  static TaskItem? doCache(String name,
      {required ValueChanged<Uint8List?> callBack}) {
    final task = _instance._imageDataStream[name];
    if (task != null) {
      task.addTaskCallBack(callBack);
    }
    return task;
  }

  static TaskItem putTask(String key, ValueChanged<Uint8List?> callBack) {
    final task = TaskItem()..addTaskCallBack(callBack);
    _instance._imageDataStream[key] = task;
    return task;
  }

  static checkCache() {
    final keys = List.from(_instance._imageDataStream.keys);
    for(final key in keys) {
      if (_instance._imageDataStream[key]!.fullData != null) {
        _instance._imageDataStream.remove(key);
        _instance._cacheCount--;
      }
      if (_instance._cacheCount == (_maxCache >> 1)) break;
    }
  }
}
