import 'package:flutter/material.dart';
import 'package:flutter_application_dday/item.dart';
import 'package:flutter_application_dday/make_page.dart';
import 'package:flutter_application_dday/shared_pref.dart';
import 'package:flutter_application_dday/widget/dday_unit.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '디데이',
      home: Scaffold(
        backgroundColor: Color(0xFF27282D),
        appBar: AppBar(
          title: Text('디데이'),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                Item? newItem = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MakePage())
                );
                if(newItem == null) return;

                await save([...items, newItem]);
                setState(() {});
              }
            )
          ],
        ),
        body: FutureBuilder<List<Item>>(
          future: readAll(),
          builder: (context, snapshot){
            if(snapshot.hasData){
                items = snapshot.data!;
                return ListView(
                  children: items.map(
                  (item) => DDayUnit(item: item)
                ).toList()
              );
            }
            return CircularProgressIndicator();
          },
        )
      )
    );
  }
}
