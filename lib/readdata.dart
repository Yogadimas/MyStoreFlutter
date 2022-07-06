import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_store_flutter/adddata.dart';
import 'package:my_store_flutter/detaildata.dart';

class ReadData extends StatefulWidget {
  const ReadData({Key? key}) : super(key: key);

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  Future<List> getData() async {
    const String linkGetData = 'https://yogadimasproject.000webhostapp.com/getdata.php' ;
    final response = await http 
        .get(Uri.parse(linkGetData));
        return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Data'),
      ), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddData()));
        },
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ItemList(
                list: snapshot.data ?? [],
              )
              : Center(
                child: CircularProgressIndicator(),
              );
        },
      ),
    );
  }
}

class ItemList  extends StatelessWidget {
  final List? list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list?.length,
      itemBuilder: (context, i){
        return Container(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Detail(
                list: list,
                index: i,
              )));
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.widgets),
                title: Text(list?[i]['item_name']),
                subtitle: Text("Stock : ${list?[i]['stock']}"),
              ),
            ),
          ),
        );
          
        
      },
    );
  }
}
