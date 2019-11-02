import 'package:flutter/material.dart';

typedef BoxDecoration DecorationBuilder(bool selected);

class PopNavItem {
  final Widget icon;
  final Widget activeIcon;
  final String title;
  final DecorationBuilder decorationBuilder;

  PopNavItem({
    this.icon,
    this.activeIcon,
    this.title,
    this.decorationBuilder,
  });
}
