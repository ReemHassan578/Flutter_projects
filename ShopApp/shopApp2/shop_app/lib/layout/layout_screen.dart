import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  goToPage(page: const SearchScreen(), context: context);
                },
              ),
            ],
          ),
          body: cubit.pages[cubit.currentIndx],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.categoriesItems,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndx,
            onTap: (value) {
              cubit.changeCategory(value);
            },
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
