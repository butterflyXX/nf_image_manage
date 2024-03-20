import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nf_image_manage/common.dart';
import 'package:nf_image_manage/nf_image_manage.dart';
import 'package:nf_image_manage/task_item.dart';

typedef WidgetBuilder = Widget Function(BuildContext context, Uint8List data);

class NativeImageBuilder extends StatefulWidget {
  final double? height;
  final double? width;
  final String name;
  final BoxFit? fit;

  const NativeImageBuilder({
    required this.name,
    this.height,
    this.width,
    this.fit,
    super.key,
  });

  @override
  State<NativeImageBuilder> createState() => _NativeImageBuilderState();
}

class _NativeImageBuilderState extends State<NativeImageBuilder> {
  Uint8List? data;
  TaskItem? _task;

  @override
  void initState() {
    updateTask();
    super.initState();
  }

  void _changed(value) {
    setState(() {
      data = value;
    });
  }

  @override
  void didUpdateWidget(covariant NativeImageBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      updateTask();
    }
  }

  @override
  void dispose() {
    _task?.removeTaskCallBack(_changed);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: data == null ? Container() : Image.memory(data!,fit: widget.fit,),
    );
  }

  updateTask() {
    _task?.removeTaskCallBack(_changed);
    _task = NfImageManage.getNativeImage(widget.name, callBack: _changed);
  }
}
