import 'package:flutter/material.dart' show BoxShadow, Colors, Offset;

class AppBoxShadow {
  static BoxShadow get materialShadow => BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10);
  static BoxShadow get containerBoxShadow => BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 6, offset: Offset(0, 2));
}
