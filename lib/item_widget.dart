import 'package:flutter/material.dart';
import 'package:pop_bottom_nav/item.dart';

class ItemWidget extends StatelessWidget {
  final Duration duration;
  final PopNavItem item;
  final bool selected;

  const ItemWidget({
    Key key,
    @required this.duration,
    @required this.item,
    this.selected = false,
  })  : assert(selected != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: duration,
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
                    ? (item.title ?? "").length * 6.0 + 36
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
      );
}
