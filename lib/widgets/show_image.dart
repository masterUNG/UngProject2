// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final double? width;
  const ShowImage({
    Key? key,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/logo.png',
      width: width ?? 150,
    );
  }
}
