import 'package:books_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:books_app/features/home/presentation/view_models/cubit/home_states.dart';
import 'package:books_app/features/home/presentation/views/widgets/home/featured_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/book_entity.dart';

class FeaturedBooksListViewBlocBuilder extends StatefulWidget {
  const FeaturedBooksListViewBlocBuilder({super.key});

  @override
  State<FeaturedBooksListViewBlocBuilder> createState() =>
      _FeaturedBooksListViewBlocBuilderState();
}

class _FeaturedBooksListViewBlocBuilderState
    extends State<FeaturedBooksListViewBlocBuilder> {

  List<BookEntity> books = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return state.when(
          fetchPaginationBooksError: (error) => FeaturedBooksListView(
            allBooks: books,
          ) ,
          fetchCertainPageBooksLoading: () => FeaturedBooksListView(
            allBooks: books,
          ),
          fetchBooksSuccessfully: (data) {
            
              books.addAll(data) ;
            
            return FeaturedBooksListView(
              allBooks: books,
            );
          },
          fetchBooksError: (error) => Text(error.getAllErrorMessages()),
          fetchFirstPageBooksLoading: () => Text('loading'),
          initial: () => Text('initial'),
        );
      },
    );
  }
}
