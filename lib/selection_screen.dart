import 'package:firebase_pagination_demo/add%20Data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'demo.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: Get.height * 0.15,
            ),
            Text(
                'Are you sure you want to \nAdd Data in Firebase \n\nThen select Yes! \notherwise Go to Pagination Screen?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: Get.height * 0.02)),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offAll(AddDataScreen());
                    },
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.height * 0.1,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(7)),
                      child: Center(
                        child: Text(
                          'Yes!',
                          style: TextStyle(fontSize: Get.height * 0.025),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(demo());
                    },
                    child: Container(
                      height: Get.height * 0.05,
                      width: Get.height * 0.1,
                      decoration: BoxDecoration(
                          color: Color(0xffA0A0A0),
                          borderRadius: BorderRadius.circular(7)),
                      child: Center(
                        child: Text(
                          'No.',
                          style: TextStyle(fontSize: Get.height * 0.025),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
