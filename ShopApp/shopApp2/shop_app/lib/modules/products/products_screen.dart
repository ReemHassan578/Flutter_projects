import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../models/categories_model.dart';
import '../../models/home_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeContents != null && cubit.categories != null,
          builder: (context) {
            return homeBuilder(cubit.homeContents!, context);
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget homeBuilder(HomeModel home, context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              enlargeCenterPage: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              scrollDirection: Axis.horizontal,
            ),
            items: home.data.banners.map((e) {
              return Image.network(
                e.image,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            }).toList(),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                      itemBuilder: (context, index) => buildCategoryItem(
                          AppCubit.get(context).categories!.data.data[index]),
                      itemCount:
                          AppCubit.get(context).categories!.data.data.length),
                ),
                const SizedBox(height: 25),
                const Text(
                  'New Products',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisSpacing: 2,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.63,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                home.data.products.length,
                (index) {
                  return builderGridItem(home.data.products[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget builderGridItem(ProductData item) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 160,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image.network(
                  item.image,
                  height: 160,
                  // fit: BoxFit.fill,
                  width: double.infinity,
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
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 33,
                  child: Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1,
                      fontSize: 12,
                    ),
                  ),
                ),
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
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border_outlined),
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

  Widget buildCategoryItem(CategoryData item) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image.network(fit: BoxFit.cover, width: 100, height: 100, item.image),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            item.name,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
