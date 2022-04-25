import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungproject2/models/user_model.dart';
import 'package:ungproject2/utility/my_constant.dart';
import 'package:ungproject2/utility/my_dialog.dart';
import 'package:ungproject2/widgets/show_button.dart';
import 'package:ungproject2/widgets/show_fome.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({Key? key}) : super(key: key);

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  String? name, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        child: Center(
          child: Column(
            children: [
              ShowForm(
                  label: 'Display Name :',
                  iconData: Icons.fingerprint,
                  changeFunc: (String string) {
                    name = string.trim();
                  }),
              ShowForm(
                  label: 'Email :',
                  iconData: Icons.email_outlined,
                  changeFunc: (String string) {
                    email = string.trim();
                  }),
              ShowForm(
                  label: 'Password :',
                  iconData: Icons.lock_outline,
                  changeFunc: (String string) {
                    password = string.trim();
                  }),
              ShowButton(
                  label: 'Create New Account',
                  pressFunc: () {
                    print('name = $name, email = $email, password = $password');

                    if ((name?.isEmpty ?? true) ||
                        (email?.isEmpty ?? true) ||
                        (password?.isEmpty ?? true)) {
                      print('Have Space');
                      MyDialog(context: context).normalDialog(
                          title: 'Have Space',
                          message: 'Please Fill Every Blank');
                    } else {
                      print('No Space');
                      processCreateNewAccount();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> processCreateNewAccount() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) async {
      String uid = value.user!.uid;
      print('Create Account Success uid ==> $uid');

      UserModel userModel =
          UserModel(email: email!, name: name!, password: password!);

      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .set(userModel.toMap())
          .then((value) {
        Navigator.pop(context);
      });
    }).catchError((onError) {
      MyDialog(context: context)
          .normalDialog(title: onError.code, message: onError.message);
    });
  }
}
