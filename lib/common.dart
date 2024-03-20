import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void nfPrint(Object? object) {
  if(kDebugMode) {
    print(object);
  }
}

void disMissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();