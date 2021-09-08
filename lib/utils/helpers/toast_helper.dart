import 'package:parking/utils/helpers/texthelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showCodeToast(String msg) {
  Fluttertoast.showToast(
    msg: codeToText(msg),
    backgroundColor: Colors.grey.shade400,
  );
}

showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.grey.shade400,
  );
}
