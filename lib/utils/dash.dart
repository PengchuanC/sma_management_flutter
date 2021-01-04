import 'dart:async';

class Dash {
  static Function debounce(Function fn, [int t = 30]) {
    Timer _debounce;
    return () {
      if (_debounce?.isActive ?? false) _debounce.cancel();

      _debounce = Timer(Duration(milliseconds: t), () {
        fn();
      });
    };
  }
}

