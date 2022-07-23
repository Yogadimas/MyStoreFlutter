import 'package:flutter/material.dart';
import 'package:my_store_flutter/editdata.dart';
import 'package:http/http.dart' as http;
import 'package:my_store_flutter/readdata.dart';
import 'package:my_store_flutter/themes/themes.dart';

import 'main.dart';

class Detail extends StatefulWidget {
  // const Detail({ Key? key }) : super(key: key);
  List? list;
  int? index;
  Detail({this.index, this.list});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deleteData() {
    var url = "https://yogadimasproject.nasiwebhost.com/deletedata.php";
    http.post(Uri.parse(url),
        body: {'id': (widget.list as dynamic)[widget.index]['id']});
  }

  void confirm() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text(
                  "Are You Sure Want To Delete ${(widget.list as dynamic)[widget.index]['item_name']} ?", style: mediumTextStyle.copyWith(
                          fontWeight: FontWeight.w500)),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      deleteData();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text('OK',  style: TextStyle(color: Colors.red)))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${(widget.list as dynamic)[widget.index]['item_name']}'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Card(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 350),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Text(
                        'Name',
                        style: mediumTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                      Text((widget.list as dynamic)[widget.index]['item_name'],
                          style: mediumTextStyle.copyWith(
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Code',
                        style: mediumTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                      Text((widget.list as dynamic)[widget.index]['item_code'],
                          style: mediumTextStyle.copyWith(
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Price',
                        style: mediumTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                      Text((widget.list as dynamic)[widget.index]['price'],
                          style: mediumTextStyle.copyWith(
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Stock',
                        style: mediumTextStyle.copyWith(
                            fontWeight: FontWeight.w500),
                      ),
                      Text((widget.list as dynamic)[widget.index]['stock'],
                          style: mediumTextStyle.copyWith(
                              fontWeight: FontWeight.w700)),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditData(
                                            list: widget.list,
                                            index: widget.index,
                                          )));
                            },
                            child: Text("Edit", style: buttonTextStyle),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              confirm();
                            },
                            child: Text("Delete", style: buttonTextStyle),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
