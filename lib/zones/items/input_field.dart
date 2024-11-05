import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final bool isSecured;
  final TextEditingController controller;
  final String? hintText;

  InputField({
    required this.title,
    required this.isSecured,
    required this.controller,
    this.hintText,
  });

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
                border: Border.all(color: Colors.transparent, width: 0),
                color: Color.fromARGB(255, 241, 241, 241),
              ),
              child: TextField(
                controller: controller,
                obscureText: isSecured,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText??title,
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
