import 'package:flutter/material.dart';

import 'item.dart';

class ListOfItems extends StatelessWidget {
  final List<dynamic> data;

  const ListOfItems(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(padding:const EdgeInsets.all(10),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [for (final i in data) Item(i)]);
  }
}
