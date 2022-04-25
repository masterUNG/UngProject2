import 'package:flutter/material.dart';

class MyConstant {
  static Color primary = const Color.fromARGB(255, 99, 162, 16);
  static Color dark = const Color.fromARGB(255, 4, 60, 18);
  static Color light = const Color.fromARGB(255, 194, 234, 142);

  static String urlAPI = 'https://randomuser.me/api/';

  TextStyle h1Style() {
    return TextStyle(
      color: dark,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      color: dark,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      color: dark,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle h3ActionStyle() {
    return const TextStyle(
      color: Color.fromARGB(255, 178, 22, 74),
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  BoxDecoration basicBox() {
    return BoxDecoration(color: light.withOpacity(0.5));
  }
}
