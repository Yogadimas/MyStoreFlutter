import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_store_flutter/detaildata.dart';
import 'package:my_store_flutter/main.dart';
import 'package:my_store_flutter/themes/themes.dart';

class EditData extends StatefulWidget {
  // const EditData({ Key? key }) : super(key: key);
  final List? list;
  final int? index;

  EditData({this.list, this.index});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerStock = TextEditingController();

  void editData() {
    var url = "https://yogadimasproject.nasiwebhost.com/editdata.php";
    http.post(Uri.parse(url), body: {
      "id": '${(widget.list as dynamic)[widget.index]['id']}',
      "itemcode": controllerCode.text,
      "itemname": controllerName.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text
    });
  }

  @override
  void initState() {
    controllerCode = TextEditingController(
        text: '${(widget.list as dynamic)[widget.index]['item_code']}');
    controllerName = TextEditingController(
        text: '${(widget.list as dynamic)[widget.index]['item_name']}');
    controllerPrice = TextEditingController(
        text: '${(widget.list as dynamic)[widget.index]['price']}');
    controllerStock = TextEditingController(
        text: '${(widget.list as dynamic)[widget.index]['stock']}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Detail(
                    list: widget.list,
                    index: widget.index,
                  )),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Data"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              TextField(
                style: mediumTextStyle,
                controller: controllerCode,
                decoration: InputDecoration(
                    hintText: "Item Code", labelText: "Item Code", labelStyle: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 15,),
              TextField(
                      style: mediumTextStyle,
                controller: controllerName,
                decoration: InputDecoration(
                    hintText: "Item Name", labelText: "Item Name", labelStyle: TextStyle(fontSize: 20)),
              ),
               SizedBox(height: 15,),
              TextField(
                      style: mediumTextStyle,
                controller: controllerPrice,
                decoration:
                    InputDecoration(hintText: "Price", labelText: "Price", labelStyle: TextStyle(fontSize: 20)),
              ),
               SizedBox(height: 15,),
              TextField(
                      style: mediumTextStyle,
                controller: controllerStock,
                decoration:
                    InputDecoration(hintText: "Stock", labelText: "Stock", labelStyle: TextStyle(fontSize: 20)),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    editData();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text("Edit Data", style: buttonTextStyle))
            ]),
          ),
        ),
      ),
    );
  }
}
