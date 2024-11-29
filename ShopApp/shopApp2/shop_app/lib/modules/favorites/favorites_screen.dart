import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../models/favorites_model.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = AppCubit.get(context);
          return ConditionalBuilder(
              condition: state is! LoadingState &&
                  cubit.homeContents != null &&
                  cubit.favorites != null,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: cubit.favorites!.data.favorites.length,
                    itemBuilder: (context, index) {
                      return buildFavoriteItem(
                          cubit.favorites!.data.favorites[index].data, context);
                    },
                  ),
                );
              },
              fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }

  Widget buildFavoriteItem(FavoriteProductData item, context) {
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image.network(
                item.image,
                height: 120,
                fit: BoxFit.fill,
                width: 120,
              ),
              if (item.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: const Text(
                    ' DISCOUNT ',
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
                )
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${item.price.round()}',
                      style: const TextStyle(
                        color: defaultColor,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (item.discount != 0)
                      Text(
                        '${item.oldPrice.round()}',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        AppCubit.get(context).toggleFavoriteProduct(item.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                            AppCubit.get(context).currentFavorites[item.id]!
                                ? defaultColor
                                : Colors.grey,
                        radius: 15,
                        child: Icon(
                            size: 14,
                            color: Colors.white,
                            Icons.favorite_border_outlined),
                      ),
                    ),
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
