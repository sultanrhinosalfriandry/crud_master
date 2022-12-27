import 'package:crud_mysql/function/func_isLoading.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'func_isLoading.dart';
import 'func_handleNull.dart';

Response<dynamic>? response;

Future<dynamic> login(context, username, password) async {
  String user, pwd;
  user = username.toString();
  pwd = password.toString();

  //jika username dan password kosong jalankan fungsi handle pada file handleNull.
  if (user == "" || pwd == "") {
    log("If pertama");
    handle("Semua data harus diisi!");
  }else{
  isLoading(context);
  response = await Dio().get(
    "https://localhost/DB_Flutter/login.php?user=bebas&pwd=bebas",
    queryParameters: {
      "user": username.toString(),
      "pwd": password.toString(),
    });
    List data = response!.data;
    log("cek sebelum if $data");

  if (data!.isEmpty) {
   log("If ketiga");
    Navigator.pop(context);
    handle("Usernama atau password salah!");
  } else {
    log("If kedua");
    return Navigator.of(context)
        .pushNamedAndRemoveUntil('/read', (Route<dynamic> route) => false);
  }
  }
}
