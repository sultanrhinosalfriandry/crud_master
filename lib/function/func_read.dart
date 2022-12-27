import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

class ListCloud {
  String id, title, desc, img;
  ListCloud(
      {required this.id,
      required this.title,
      required this.desc,
      required this.img});
}

Future<List<ListCloud>> read(query) async {
  List<ListCloud> dataList = <ListCloud>[];
  ListCloud tmpData;
  final response = await Dio().get(
    "https://localhost/DB_Flutter/listnews.php?key",
    queryParameters: {
      "key": query.toString(),
    });
    log("test query: $query");
    log("test read data: ${response.data[0]}");
    var data = response.data;
    log("test decode: ${data[0]}");

  if (data.length == 0) {
    return dataList;
  } else {
    List<ListCloud> tdata = [];
    data.forEach((item) {
      tmpData = ListCloud(
          id: item["id"]!,
          title: item["title"]!,
          desc: item["desc"]!,
          img: item["img"]!);
      dataList.add(tmpData);
    });
    return dataList;
  }
}
