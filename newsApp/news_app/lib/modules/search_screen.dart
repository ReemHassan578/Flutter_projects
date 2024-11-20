import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/widgets/category_builder.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class SearchsScreen extends StatelessWidget {
  SearchsScreen({super.key});
  final searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = NewsCubit.get(context);
        final list = cubit.search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: SearchController(),
                  onChanged: (value) {
                    cubit.getSearchData(key: 'q', typedText: value);
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search), hintText: 'Search'),
                ),
              ),
              Expanded(child: CategoryBuilder(list: list, isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
