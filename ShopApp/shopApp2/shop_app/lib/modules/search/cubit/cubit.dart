import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());
  SearchModel? result;

  static SearchCubit get(context) {
    return BlocProvider.of(context);
  }

  search(String text) {
    emit(LoadingSearchState());

    DioHelper.postData(SEARCH, data: {
      'text': text
    }, headers: {
      'lang': 'en',
      'Content-Type': 'multipart/form-data',
      'Authorization': token,
    }).then(
      (value) {
        result = SearchModel.fromJson(value.data);
        emit(SuccussSearchState());
      },
    ).catchError((error) {
      emit(ErrorSearchState(error.toString()));
    });
  }
}
