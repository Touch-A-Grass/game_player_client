import 'package:flutter/material.dart';

abstract class PageMapper<S> {
  Page map(BuildContext context, S state);

  Page page(Widget screen, {bool fullscreenDialog = false}) {
    return MaterialPage(
      key: ValueKey(screen.runtimeType),
      fullscreenDialog: fullscreenDialog,
      child: screen,
    );
  }

  Page dialogPage(Widget screen) {
    return MaterialPage(
      key: ValueKey(screen.runtimeType),
      child: screen,
      fullscreenDialog: true,
    );
  }
}
