import 'dart:convert';

import 'package:firebase_pagination_demo/constant.dart';
import 'package:firebase_pagination_demo/demo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  List finalData = [];
  getApiData() async {
    String url =
        "https://tcm.sataware.dev/json/data_forums.php?tag=&post=&filter=&user_id=";
    http.Response response = await http.get(Uri.parse(url));
    var data = response.body;
    var c = response.statusCode == 200;
    // print('data === ${jsonDecode(data)['data']}');
    if (response.statusCode == 200) {
      setState(() {
        finalData = jsonDecode(data)['data'];
      });
      return jsonDecode(response.body);
    } else {
      return "";
    }
  }

  @override
  void initState() {
    getApiData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('finalData === $finalData');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        finalData.forEach((element) {
                          fireStore.collection("data").add(element);
                          print('element >>> ${element['post_id']}');
                        });
                      },
                      child: Text("Add data"))),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.off(demo());
                      },
                      child: Text("Go to Pagination Screen"))),
              Expanded(
                child: ListView.builder(
                  itemCount: finalData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text("${finalData[index]['post_title']}"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
