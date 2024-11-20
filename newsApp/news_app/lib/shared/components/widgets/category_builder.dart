import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'NewContainer.dart';

class CategoryBuilder extends StatelessWidget {
  const CategoryBuilder({super.key, required this.list, this.isSearch});

  final List list;
  final bool? isSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ConditionalBuilder(
        condition: list.isNotEmpty,
        fallback: (context) {
          return isSearch != null
              ? Container()
              : const Center(child: CircularProgressIndicator());
        },
        builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (context, index) => NewContainer(data: list[index]),
          itemCount: list.length,
        ),
      ),
    );
  }
}
