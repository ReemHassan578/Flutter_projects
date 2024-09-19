import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final dynamic itemData;
  const Item(this.itemData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
              child: Stack(alignment: Alignment.topRight, children: [
            Image.network(
              itemData['image'],
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            IconButton.filled(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, iconColor: Colors.blueGrey),
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ])),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemData['title'],
                  maxLines: 2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text(
                      'EGP ',
                    ),
                    Text(itemData['price'].toString()),
                  ],
                ),
                Row(
                  children: [
                    Text('Review(${itemData['rating']['rate'].toString()})'),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 197, 178, 6),
                    ),
                    const Spacer(),
                    IconButton.filled(
                      icon: const Icon(
                        Icons.add,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
