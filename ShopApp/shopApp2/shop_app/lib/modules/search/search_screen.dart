import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/widgets/default_textformfield.dart';
import 'package:shop_app/shared/cubit/states.dart';

import '../../models/search_model.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final searchText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          builder: (context, state) {
            final cubit = SearchCubit.get(context);
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DefaultTextFormField(
                          onSubmit: (value) {
                            if (_formKey.currentState!.validate()) {
                              SearchCubit.get(context).search(value);
                            }
                          },
                          type: TextInputType.text,
                          controller: SearchController(),
                          label: 'Search',
                          preIcon: Icons.search,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'enter text to search';
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is LoadingSearchState)
                        LinearProgressIndicator(),
                      if (cubit.result != null)
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15,
                            ),
                            itemBuilder: (context, index) => buildSearchItem(
                                cubit.result!.data.products[index], context),
                            itemCount: cubit.result!.data.products.length,
                          ),
                        )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is LoadingSearchState) {}
          },
        ));
  }

  Widget buildSearchItem(Data item, context) {
    return SizedBox(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Stack(
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
                      icon: BlocConsumer<AppCubit, AppStates>(
                        listener: (context, state) {},
                        builder: (context, state) => CircleAvatar(
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
