import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/my_colors.dart';
import '../widgets/movie_item.dart';
import '../../business_logic/cubit/cubit/movies_cubit.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  bool isSearch = false;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearch
          ? AppBar(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {});

                    MoviesCubit.get(context).searchForMovie(value.trim());
                  },
                  style: const TextStyle(color: MyColors.myGrey),
                  controller: searchController,
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(color: MyColors.myGrey),
                      hintText: 'enter your movie ',
                      border: InputBorder.none),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (searchController.text.trim().isEmpty) {
                      Navigator.of(context).pop();
                    } else {
                      searchController.clear();
                    }

                    setState(() {});
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            )
          : AppBar(
              title: const Row(
                children: [
                  SizedBox(width: 40),
                  Text('Characters'),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    ModalRoute.of(context)!
                        .addLocalHistoryEntry(LocalHistoryEntry(
                      onRemove: () {
                        searchController.clear();
                        setState(() {
                          isSearch = false;
                        });
                      },
                    ));
                    setState(() {
                      isSearch = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
      body: BlocBuilder<MoviesCubit, MoviesStates>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: (!isSearch && MoviesCubit.get(context).movies != null) ||
                (isSearch && searchController.text.trim().isEmpty ||
                    MoviesCubit.get(context).movies != null),
            builder: (context) => buildBody(context),
            fallback: (context) => showLoadingIndicator(),
          );
        },
      ),
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildBody(BuildContext context) {
    final cubit = MoviesCubit.get(context);

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          crossAxisCount: 2,
          childAspectRatio: 2 / 3),
      itemBuilder: (context, index) {
        return isSearch && searchController.text.trim().isNotEmpty
            ? MovieItem(context: context, movie: cubit.searchMovies![index])
            : MovieItem(context: context, movie: cubit.movies![index]);
      },
      itemCount: isSearch && searchController.text.trim().isNotEmpty
          ? cubit.searchMovies!.length
          : cubit.movies!.length,
    );
  }
}
