import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_store_flutter/adddata.dart';
import 'package:my_store_flutter/detaildata.dart';
import 'package:my_store_flutter/themes/themes.dart';

class ReadData extends StatefulWidget {
  // const ReadData({Key? key}) : super(key: key);

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  List items = [];
  Future<List> getData() async {
    const String linkGetData =
        'https://yogadimasproject.nasiwebhost.com/getdata.php';
    final response = await http.get(Uri.parse(linkGetData));
    items = json.decode(response.body);
    return json.decode(response.body);
  }

  Future refresh() async {
    setState(() {
      items.clear();
    });
    setState(() {
      getData();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Data'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          Widget widget;
          if (snapshot.hasData) {
            if (items.isNotEmpty) {
              widget = RefreshIndicator(
                onRefresh: refresh,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text("Swipe down to refresh the page"),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data?.length,
                        itemBuilder: (context, i) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => Detail(
                                          list: snapshot.data ?? [],
                                          index: i,
                                        )));
                              },
                              child: Card(
                                child: ListTile(
                                  leading: Icon(Icons.widgets_rounded),
                                  title: Text(
                                    snapshot.data?[i]['item_name'],
                                    style: mediumTextStyle,
                                  ),
                                  subtitle: Text(
                                    "Stock : ${snapshot.data?[i]['stock']}",
                                    style: mediumTextStyle.copyWith(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            } else {
              widget = Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            widget = Center(
              child: CircularProgressIndicator(),
            );
          }
          return widget;
        },
      ),
    );
  }
}
