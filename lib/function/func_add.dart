import 'package:crud_mysql/function/func_handleNull.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'func_isLoading.dart';

addData(context, jdl, description, pathImg) async {
  //handle data kosong
  if (jdl == null || description == null || pathImg == null) {
    handle("Semua data harus diisi!");
  } else {
    isLoading(context);
    String imgName = pathImg.path.split('/').last;
    FormData sendData = FormData.fromMap({
      "judul": jdl.toString(),
      "deskripsi": description.toString(),
      "url_image": await MultipartFile.fromFile(pathImg.path, filename: imgName.toString()),
    });
    final response = await Dio().get(
      "https://localhost/DB_Flutter/addnews.php",
      data: sendData);
      log("test send data :" + jdl.toString());

    return Navigator.of(context)
        .pushNamedAndRemoveUntil('/read', (Route<dynamic> route) => false);
  }
}
