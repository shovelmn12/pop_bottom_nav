import 'dart:async';

import 'package:flutter/widgets.dart';

class PopBottomNavController extends ChangeNotifier {
  final StreamController<int> _controller = StreamController.broadcast();

  Stream<int> get stream => _controller.stream;

  int _index = 0;

  int get index => _index;

  set index(int i) {
    if (i != index) {
      _index = i;

      _controller.add(i);
      notifyListeners();
    }
  }

  PopBottomNavController({
    int index = 0,
  })  : assert(index != null),
        _index = index {
    _controller.add(index);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
