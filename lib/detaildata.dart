import 'package:flutter/material.dart';
import 'package:my_store_flutter/editdata.dart';

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
                      onPressed: () {},
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
