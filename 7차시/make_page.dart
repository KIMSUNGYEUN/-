import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_dday/item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class MakePage extends StatefulWidget {
  @override
  _MakePageState createState() => _MakePageState();
}

class _MakePageState extends State<MakePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String? imagePath;

  void complete(){
    if(titleController.text.isEmpty) return;
    if(dateController.text.isEmpty) return;

    //RegExp exp = RegExp(r"");
    // ex) 2021-08-19

    //exp.hasMatch(dateController.text);

    DateTime? date;
    try{
      date = DateFormat('yyyy-MM-dd').parse(dateController.text);
    } on FormatException{ return; }

    Item result = Item(
      title: titleController.text,
      date: date,
      imagePath: imagePath
    );
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF27282D),
      appBar: AppBar(
        title: Text('생성하기'),
        backgroundColor: Color(0xFF1D1D1D),
        actions: [
          TextButton(
            child: Text("완료", style: TextStyle(fontSize: 17)),
            onPressed: () {
              complete();
            }
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _customImageButton(),
            _customTextField('제목', titleController),
            _customTextField('날짜', dateController)
          ],
        )
      )
    );
  }

  Widget _customTextField(String text, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 24,
        ),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(color: Color(0xFF5A5B6A)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x33D4D4D4)),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFFFFF)),
          ),
        )
      )
    );
  }


  Widget _customImageButton() {
    Widget image = Icon(Icons.photo_album, color:  Color(0xFF5A5B6A));

    if(imagePath != null){
      image = Image.file(
        File(imagePath!),
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: TextButton(
          child: image,
          onPressed: () async{
            XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
            if(image == null) return;

            setState(() {
              imagePath = image.path;
            });
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              Color(0xFF3C3D46)
            )
          ),  
            //child: image
        )
      )
    );
  }
}
