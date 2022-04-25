// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ungproject2/utility/my_constant.dart';
import 'package:ungproject2/widgets/show_image.dart';
import 'package:ungproject2/widgets/show_text.dart';
import 'package:ungproject2/widgets/show_text_button.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> normalDialog(
      {required String title, required String message}) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ListTile(
          leading: const ShowImage(width: 50,),
          title: ShowText(label: title, textStyle: MyConstant().h2Style(),),
          subtitle: ShowText(label: message),
        ),
        actions: [ShowTextButton(label: 'OK', pressFunc: ()=>Navigator.pop(context))],
      ),
    );
  }
}
