import 'package:shared_preferences/shared_preferences.dart';

import 'item.dart';
//저장하고 맵을 씀
Future<List<Item>> readAll() async{
  final prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('data') ?? [];
  return data.map((itemStr) => Item.fromJsonString(itemStr)).toList();
}
//맵을 쓰고 저장
Future<void> save(List<Item> data) async{
  final prefs = await SharedPreferences.getInstance();
  List<String> jsonStringList = data.map((item) => item.toJsonString()).toList();
  prefs.setStringList('data', jsonStringList);
}
