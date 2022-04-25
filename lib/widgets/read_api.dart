import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungproject2/models/info_model.dart';
import 'package:ungproject2/utility/my_constant.dart';
import 'package:ungproject2/widgets/show_text.dart';

class ReadAPI extends StatefulWidget {
  const ReadAPI({Key? key}) : super(key: key);

  @override
  State<ReadAPI> createState() => _ReadAPIState();
}

class _ReadAPIState extends State<ReadAPI> {
  bool load = true;
  InfoModel? infoModel;

  @override
  void initState() {
    super.initState();
    readDataFromAPI();
  }

  Future<void> readDataFromAPI() async {
    await Dio().get(MyConstant.urlAPI).then((value) {
      // print('value from API ==> $value');

      infoModel = InfoModel.fromMap(value.data);
      print('infoModel ==>> ${infoModel!.toMap()}');
      load = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? const Center(child: CircularProgressIndicator())
        : Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowText(label: 'Seed ==> ${infoModel!.info.seed}'),
            ShowText(label: 'results ==> ${infoModel!.info.results}'),
            ShowText(label: 'page ==> ${infoModel!.info.page}'),
            ShowText(label: 'version ==> ${infoModel!.info.version}'),
          ],
        );
  }
}
