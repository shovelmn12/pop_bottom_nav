library pop_bottom_nav;

import 'package:flutter/material.dart';
import 'package:pop_bottom_nav/item.dart';
import 'package:pop_bottom_nav/item_widget.dart';

export 'package:pop_bottom_nav/item.dart';

class PopBottomNav extends StatefulWidget {
  final TabController controller;
  final int selected;
  final List<PopNavItem> items;
  final ValueChanged<int> onChanged;
  final BoxDecoration decoration;
  final double height;
  final Duration duration;
  final TextStyle textStyle;

  const PopBottomNav({
    Key key,
    this.controller,
    this.selected = 0,
    @required this.items,
    this.onChanged,
    this.decoration,
    this.height = 75,
    this.duration = const Duration(milliseconds: 200),
    this.textStyle,
  })  : assert(selected != null),
        assert(items != null),
        assert(height != null),
        assert(duration != null),
        super(key: key);

  @override
  PopBottomNavState createState() => PopBottomNavState();
}

class PopBottomNavState extends State<PopBottomNav> {
  int _selected;

  @override
  void initState() {
    widget.controller?.addListener(_onControllerChange);
    _selected = widget.selected ?? 0;

    super.initState();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChange);

    super.dispose();
  }

  void _onControllerChange() {
    final index = widget.controller.index;

    if (index != _selected) {
      _selected = index;

      setState(() {});

      widget.onChanged?.call(_selected);
    }
  }

  void _onPageChange(int to) {
    widget.controller?.index = to;

    if (to != _selected) {
      _selected = to;

      setState(() {});

      widget.onChanged?.call(_selected);
    }
  }

  Widget _buildItem(
    BuildContext context,
    PopNavItem item,
    int index,
    bool selected,
  ) =>
      GestureDetector(
        onTap: () => _onPageChange(index),
        child: ItemWidget(
          duration: widget.duration,
          item: item,
          selected: selected,
        ),
      );

  @override
  Widget build(BuildContext context) => Material(
        textStyle: widget.textStyle ??
            Theme.of(context).textTheme.caption.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          height: widget.height,
          decoration: widget.decoration ??
              BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.8),
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.items.map(
                (i) {
                  final index = widget.items.indexOf(i);

                  return _buildItem(
                    context,
                    widget.items[index],
                    index,
                    index == _selected,
                  );
                },
              ).toList(),
            ),
          ),
        ),
      );
}
