import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchsScreen(),
                  ));
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                  onPressed: () async {
                    await cubit.changeThemeMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                cubit.changeBotomNavBar(value);
              },
              currentIndex: cubit.currentPage,
              items: cubit.bottomNavBarItems),
          body: cubit.pages[cubit.currentPage],
        );
      },
    );
  }
}
