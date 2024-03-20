import 'package:flutter/material.dart';
import 'package:nf_image_manage/nf_image_manage.dart';
import 'package:nf_image_manage/widget/image.dart';

void main() {

  // 设置最大缓存
  NfImageManage.config(maxCache: 1 << 3);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> data = ["flag_ad","flag_ag","flag_af","flag_ae","flag_am","flag_ao","flag_aq","flag_ar"];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (_,index) {
          // return SizedBox(height: 200,child: Center(child: Text("123"),),);
          return Container(child: NativeImageBuilder(name: data[index],height: 400,),color: Colors.green,);
        },
      ),
    );
  }
}

