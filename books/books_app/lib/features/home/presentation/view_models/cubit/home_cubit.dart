import 'package:books_app/features/home/domain/use_cases/fetch_all_books_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final FetchAllBooksUseCase _fetchAllBooksUseCase;

  HomeCubit( this._fetchAllBooksUseCase) : super(HomeStates.initial());

  static HomeCubit get(BuildContext context) {
return BlocProvider.of(context);
  }

  Future<void> fetchAllBook(int currentPage) async {
   if(currentPage == 0) {emit(HomeStates.fetchFirstPageBooksLoading());}
   else{emit(HomeStates.fetchCertainPageBooksLoading());}
    var result = await _fetchAllBooksUseCase.fetchAllBooks(currentPage);
    result.whenOrNull(
      success: (allBooks) {
        emit(HomeStates.fetchBooksSuccessfully(allBooks));
      },
      failure: (error) {
      if(currentPage == 0)  { emit(HomeStates.fetchBooksError(error));}
      else{emit(HomeStates.fetchPaginationBooksError(error));}
      },
    );
  }
}
