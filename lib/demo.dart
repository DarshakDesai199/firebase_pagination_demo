import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_pagination_demo/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  DocumentSnapshot? lastDocument;

  int limit = 4;

  late QuerySnapshot<Map<String, dynamic>> querySnapshot;

  bool isMore = true;

  List<Map<String, dynamic>> list = [];

  final ScrollController scrollController = ScrollController();

  bool isLoading = false;

  Future<void> paginationData() async {
    if (isMore) {
      setState(() {
        isLoading = true;
      });

      final collectionRef = fireStore.collection('data');
      if (lastDocument == null) {
        querySnapshot = await collectionRef.limit(limit).get();
      } else {
        querySnapshot = await collectionRef
            .limit(limit)
            .startAfterDocument(lastDocument!)
            .get();
      }

      lastDocument = querySnapshot.docs.last;

      list.addAll(querySnapshot.docs.map((e) => e.data()));
      isLoading = false;
      print('Total length == ${list.length}');
      setState(() {});

      if (querySnapshot.docs.length < limit) {
        isMore = false;
      }
    } else {
      print('No Data');
    }
  }

  @override
  void initState() {
    paginationData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        paginationData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      appBar: AppBar(
        title: Text('Pagination'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      color: Color(0xff171717),
                      borderOnForeground: true,
                      child: Column(children: [
                        Expanded(
                            flex: 2,
                            child: Image.network(
                              "${list[index]['profile_pic']}",
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )),
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${list[index]['username']}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        '${list[index]['post_date']}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${list[index]['user_id']}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      Text(
                                        '${list[index]['post_title']}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ]),
                    ),
                  ),
                );
              },
            ),
          ),
          Visibility(
              visible: isLoading,
              replacement: SizedBox(),
              child: CircularProgressIndicator()),
          /* isLoading ? Center(child: CircularProgressIndicator()) : SizedBox()*/
        ],
      ),
    );
  }
}
