import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungproject2/states/create_new_account.dart';
import 'package:ungproject2/states/my_service.dart';
import 'package:ungproject2/utility/my_constant.dart';
import 'package:ungproject2/utility/my_dialog.dart';
import 'package:ungproject2/widgets/show_button.dart';
import 'package:ungproject2/widgets/show_fome.dart';
import 'package:ungproject2/widgets/show_image.dart';
import 'package:ungproject2/widgets/show_text.dart';
import 'package:ungproject2/widgets/show_text_button.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: MyConstant().basicBox(),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 320,
                  child: Row(
                    children: [
                      const ShowImage(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      ShowText(
                        label: 'Login',
                        textStyle: MyConstant().h1Style(),
                      ),
                    ],
                  ),
                ),
                ShowForm(
                  label: 'Email :',
                  iconData: Icons.mail_outline,
                  changeFunc: (String string) {
                    email = string.trim();
                  },
                ),
                ShowForm(
                  obsecu: true,
                  label: 'Password :',
                  iconData: Icons.lock_outline,
                  changeFunc: (String string) {
                    password = string.trim();
                  },
                ),
                ShowButton(
                  label: 'Login',
                  pressFunc: () {
                    if ((email?.isEmpty ?? true) ||
                        (password?.isEmpty ?? true)) {
                      MyDialog(context: context).normalDialog(
                          title: 'Have Space ?',
                          message: 'Please Fill Every Blank');
                    } else {
                      processCheckAuthen();
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ShowText(label: 'Non Account ? '),
                    ShowTextButton(
                      label: 'Create Account',
                      pressFunc: () {
                        print('You Click');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateNewAccount(),
                            ));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> processCheckAuthen() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      print('Login Success');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyService(),
          ),
          (route) => false);
    }).catchError((onError) {
      MyDialog(context: context)
          .normalDialog(title: onError.code, message: onError.message);
    });
  }
}
