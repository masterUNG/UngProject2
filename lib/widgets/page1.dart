import 'package:flutter/material.dart';
import 'package:ungproject2/utility/my_constant.dart';
import 'package:ungproject2/widgets/show_button.dart';
import 'package:ungproject2/widgets/show_image.dart';
import 'package:ungproject2/widgets/show_text.dart';
import 'package:ungproject2/widgets/show_text_button.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowButton(
            label: 'ModalButtonSheet',
            pressFunc: () {
              processModalButtonSheet(context);
            }),
      ],
    );
  }

  Future<void> processModalButtonSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => SizedBox(
        // height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ShowImage(),
            ShowText(
              label: 'This is BodalButtonSheet',
              textStyle: MyConstant().h2Style(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShowTextButton(
                  label: 'OK',
                  pressFunc: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
