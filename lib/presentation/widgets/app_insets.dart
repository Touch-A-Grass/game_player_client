import 'package:flutter/cupertino.dart';

class AppInsets extends EdgeInsets {
  const AppInsets.topHorizontal(final double value) : super.only(top: value, left: value, right: value);
}
