import 'package:flutter/cupertino.dart';

class DashboardItem {
  final String name;
  final IconData icon;
  final String url;

  const DashboardItem(
      {required this.name, required this.icon, required this.url});

  DashboardItem.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        icon = IconData(int.parse(json["icon"]),
            fontFamily: json["fontFamily"], fontPackage: json["fontPackage"]),
        url = json["url"];
}
