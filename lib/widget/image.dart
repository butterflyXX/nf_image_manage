import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nf_image_manage/nf_image_manage.dart';

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

  @override
  void initState() {
    NfImageManage.getNativeImage(widget.name, callBack: (value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: data == null ? Container() : Image.memory(data!,fit: widget.fit,),
    );
  }
}
