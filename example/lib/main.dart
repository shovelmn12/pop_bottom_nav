import 'package:flutter/material.dart';
import 'package:pop_bottom_nav/item.dart';
import 'package:pop_bottom_nav/pop_bottom_nav.dart';

void main() => runApp(PopExample());

class PopExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          bottomNavigationBar: PopBottomNav(
            items: <PopNavItem>[
              PopNavItem(
                icon: Icon(Icons.perm_identity),
              ),
              PopNavItem(
                icon: Icon(Icons.home),
              ),
              PopNavItem(
                icon: Icon(Icons.settings),
                title: "sdad",
              ),
            ],
          ),
        ),
      );
}
