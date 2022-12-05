import 'package:flutter/material.dart';

class Styles {
  static Color sakura = const Color.fromARGB(255, 255,216,235);
  static Color cream = const Color.fromARGB(255, 255,233,243);
  static Color cloud = const Color.fromARGB(255, 252,248,249);
  static Color sky = const Color.fromARGB(255, 207,215,253);
  static Color aqua = const Color.fromARGB(255, 187,197,248);
  static Color sugar = const Color.fromARGB(255, 86,86,107);

  static InputDecoration textInputDecoration = InputDecoration(
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(12))
    ),

    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Styles.aqua, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(12))
    ),

    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Styles.cream, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(12))
    ),
  );
}

