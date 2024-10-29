import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemsForm extends StatefulWidget {
  const AddItemsForm({super.key});

  @override
  State<AddItemsForm> createState() => _AddItemsFormState();
}

class _AddItemsFormState extends State<AddItemsForm> {
  double _dialogHeight = 0.0;
  double _dialogWidth = Get.width;


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 50), (){
      setState(() {
        _dialogHeight = Get.height /1.30;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
