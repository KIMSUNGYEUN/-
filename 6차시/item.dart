import 'dart:convert';

import 'package:intl/intl.dart';

class Item {
  String title;
  DateTime date;
  String? imagePath;

  Item({
    required this.title,
    required this.date,
    this.imagePath
  });

  //ex) 2021년 8월 5일 -> 2021-08-05
  String toJsonString() {
    String dateString = DateFormat('yyyy-MM-dd').format(date);
    return jsonEncode({'title': title, 'targetDate': dateString, 'image': imagePath});
  }

  factory Item.fromJsonString(String jsonString) {
    return Item.fromJson(jsonDecode(jsonString));
  }

  factory Item.fromJson(dynamic json) {
    String title = json['title'];
    DateTime date = DateFormat('yyyy-MM-dd').parse(json['targetDate']);
    String? imagePath = json['image'];
    return Item(title: title, date: date, imagePath: imagePath);
  }
}
