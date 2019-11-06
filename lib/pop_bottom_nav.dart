library pop_bottom_nav;

import 'package:flutter/material.dart';
import 'package:pop_bottom_nav/item.dart';

export 'package:pop_bottom_nav/controller.dart';
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
      Expanded(
        child: Center(
          child: GestureDetector(
            onTap: () => _onPageChange(index),
            child: AnimatedContainer(
              duration: widget.duration,
              decoration: item.decorationBuilder?.call(selected) ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: selected ? Colors.white : Colors.transparent,
                    boxShadow: [
                      if (selected)
                        BoxShadow(
                          offset: Offset(8, 0),
                          color: Theme.of(context).primaryColor.withOpacity(.6),
                          blurRadius: 94,
                        )
                    ],
                  ),
              height: 34,
              width: selected
                  ? 34 +
                      (item.title.isNotEmpty
                          ? (item.title ?? "").length * 5.0 + 36
                          : 0)
                  : 34,
              child: Padding(
                padding: selected && item.title.isNotEmpty
                    ? const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      )
                    : const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                child: selected
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: IconTheme(
                                  data: IconThemeData(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: item.activeIcon ?? item.icon),
                            ),
                          ),
                          if (item.title.isNotEmpty)
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: Text(
                                  item.title ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                        ],
                      )
                    : IconTheme(
                        data: IconThemeData(
                          color: Colors.white,
                        ),
                        child: item.icon,
                      ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Material(
        textStyle: widget.textStyle ??
            Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 14,
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
