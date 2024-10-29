import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  String title;
  bool isSecured; //set to true to hide content

  InputField({required this.title, required this.isSecured});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(title),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 200,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color:Colors.transparent, width: 0),
                color: Color.fromARGB(255, 241, 241, 241),
              ),
              child: TextField(
                obscureText: isSecured,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: title,
                  hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            ),
          )
        ],
      ),
    );


  }
}
