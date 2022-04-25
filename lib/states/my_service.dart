import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungproject2/models/user_model.dart';
import 'package:ungproject2/states/authen.dart';
import 'package:ungproject2/utility/my_constant.dart';
import 'package:ungproject2/widgets/page1.dart';
import 'package:ungproject2/widgets/read_api.dart';
import 'package:ungproject2/widgets/show_image.dart';
import 'package:ungproject2/widgets/show_text.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  bool load = true;
  UserModel? userModel;
  var widgets = <Widget>[
    const ReadAPI(),
    const Page1(),
  ];
  int indexWidget = 0;

  @override
  void initState() {
    super.initState();
    readDataUser();
  }

  Future<void> readDataUser() async {
    var user = FirebaseAuth.instance.currentUser;
    String uid = user!.uid;
    print('uid ==> $uid');

    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data()!);
      load = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const ShowImage(),
              decoration: MyConstant().basicBox(),
              accountName: ShowText(
                label: userModel == null ? '' : userModel!.name,
                textStyle: MyConstant().h2Style(),
              ),
              accountEmail:
                  ShowText(label: userModel == null ? '' : userModel!.email),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  indexWidget = 0;
                });
              },
              leading: Icon(
                Icons.home_outlined,
                color: MyConstant.dark,
              ),
              title: ShowText(
                label: 'Read API',
                textStyle: MyConstant().h2Style(),
              ),
              subtitle: const ShowText(label: 'Show Demo Read API From Server'),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  indexWidget = 1;
                });
              },
              leading: Icon(
                Icons.pages,
                color: MyConstant.dark,
              ),
              title: ShowText(
                label: 'Page 1',
                textStyle: MyConstant().h2Style(),
              ),
              subtitle: const ShowText(label: 'Show Page 1'),
            ),
            const Spacer(),
            newSignOut(),
          ],
        ),
      ),
      body: load
          ? const Center(child: CircularProgressIndicator())
          : widgets[indexWidget],
    );
  }

  ListTile newSignOut() {
    return ListTile(
      onTap: () async {
        await FirebaseAuth.instance.signOut().then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Authen()),
              (route) => false);
        });
      },
      tileColor: Colors.red.withOpacity(0.5),
      leading: Icon(
        Icons.exit_to_app,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowText(
        label: 'SignOut',
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}
