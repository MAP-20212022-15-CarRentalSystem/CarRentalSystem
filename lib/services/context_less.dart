import 'package:flutter/material.dart';

class ContextLess {
  ContextLess._();
  static final GlobalKey<NavigatorState> navigatorkey =
      GlobalKey<NavigatorState>();

  static NavigatorState get nav {
    return Navigator.of(navigatorkey.currentContext);
  }

  static BuildContext get context {
    return navigatorkey.currentContext;
  }
}

extension TinyContextNavigator on BuildContext {
  NavigatorState get nav {
    return Navigator.of(this);
  }
}
