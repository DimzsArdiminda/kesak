import 'package:flutter/material.dart';
import 'package:kesak_fe/app/settings/shortcut/shortcut.dart';
import 'package:kesak_fe/components/Colors.dart';
import 'package:kesak_fe/helper/router.dart';

List<Map<String, dynamic>> getMenuSettings(BuildContext context) {
  return [
    {
      "title": "Shortcuts Menu",
      "icon": Icons.menu_rounded,
      "iconType": "icon", // "icon" atau "image"
      "color": secondaryColor,
      "onTap": () => navigateTo(context, Shortcut()),
    },
    {
      "title": "Security",
      "icon": Icons.security_rounded,
      "iconType": "icon", // "icon" atau "image"
      "color": secondaryColor,
      "onTap": null,
    },
    {
      "title": "Notifications",
      "icon": Icons.notifications_rounded,
      "iconType": "icon", // "icon" atau "image"
      "color": secondaryColor,
      "onTap": null,
    },
  ];
}
