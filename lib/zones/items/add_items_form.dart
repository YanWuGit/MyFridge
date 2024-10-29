import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_fridge/zones/items/input_field.dart';

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
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _dialogHeight = Get.height / 1.30;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color:Colors.transparent, width: 0),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.blueAccent,
              ),
              width: _dialogWidth,
              child: const Center(
                child: Text(
                  'Add A Item',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          InputField(
            title: 'Item Name',
            isSecured: false,
          ),
          const SizedBox(
            height: 20,
          ),
          InputField(
            title: 'Item Amount',
            isSecured: false,
          ),
          const SizedBox(
            height: 20,
          ),
          InputField(
            title: 'Days Until Expire',
            isSecured: false,
          ),
        ],
      ),
    );
  }
}
