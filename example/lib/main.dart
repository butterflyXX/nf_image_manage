import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nf_image_manage/nf_image_manage.dart';
import 'package:nf_image_manage/widget/image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _nfImageManagePlugin = NfImageManage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: NativeImageBuilder(name: "test.png",fit: BoxFit.cover,width: double.infinity,),
      ),
    );
  }
}
