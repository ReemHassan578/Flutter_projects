import 'package:flutter/material.dart';

import '../../../modules/web_page.dart';

class NewContainer extends StatelessWidget {
  final Map<String, dynamic> data;

  const NewContainer({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WebPage(data['url']),
        ));
      },
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: data['urlToImage'] != null
                ? Image.network(
                    data['urlToImage'],
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Text('😢'),
                    ),
                    fit: BoxFit.cover,
                  )
                : const Center(child: Text('😢')),
          ),
          const SizedBox(width: 20),
          Expanded(
              child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    data['title'],
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(data['publishedAt'],
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
