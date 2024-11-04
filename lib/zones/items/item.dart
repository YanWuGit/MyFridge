import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  final String itemName;
  final int itemAmount;
  final double itemWidth;

  const Item({
    required this.itemName,
    required this.itemAmount,
    required this.itemWidth,
    super.key
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: widget.itemWidth,
      child: Card(
        color: Colors.lightBlueAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.gif_box),
                iconSize: 60,
                color: Colors.amber,
              ),
              Text(widget.itemName),
              Text('${widget.itemAmount}')
            ],
          ),
        ),
      ),
    );
  }
}
