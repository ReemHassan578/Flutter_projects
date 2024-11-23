import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  buildCategoryItem(cubit.categories!.data.data[index]),
              separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                  ),
              itemCount: cubit.categories!.data.data.length),
        );
      },
      listener: (BuildContext context, AppStates state) {},
    );
  }

  Widget buildCategoryItem(CategoryData item) {
    return Row(
      children: [
        SizedBox(
            width: 80,
            height: 80,
            child: Image.network(item.image,
                height: 80, width: 80, fit: BoxFit.cover)),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios_outlined))
      ],
    );
  }
}
