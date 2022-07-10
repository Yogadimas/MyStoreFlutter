import 'package:flutter/material.dart';
import 'package:my_store_flutter/editdata.dart';
import 'package:http/http.dart' as http;
import 'package:my_store_flutter/readdata.dart';

import 'main.dart';

class Detail extends StatefulWidget {
  // const Detail({ Key? key }) : super(key: key);
  List? list;
  int? index;
  final VoidCallback? reload;
  Detail({this.index, this.list, this.reload});

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
                  "Are You Sure Want To Delete ${(widget.list as dynamic)[widget.index]['item_name']}"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      deleteData();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyApp()), 
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text('OK'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${(widget.list as dynamic)[widget.index]['item_name']}'),
        ),
        body: Container(
          height: 250,
          padding: EdgeInsets.all(20),
          child: Card(
            child: Center(
                child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 20)),
                Text((widget.list as dynamic)[widget.index]['item_name'],
                    style: TextStyle(fontSize: 20)),
                Text((widget.list as dynamic)[widget.index]['item_code'],
                    style: TextStyle(fontSize: 20)),
                Text((widget.list as dynamic)[widget.index]['price'],
                    style: TextStyle(fontSize: 20)),
                Text((widget.list as dynamic)[widget.index]['stock'],
                    style: TextStyle(fontSize: 20)),
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
                      child: Text("Edit"),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        confirm();
                      },
                      child: Text("Delete"),
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                    ),
                  ],
                )
              ],
            )),
          ),
        ));
  }
}
