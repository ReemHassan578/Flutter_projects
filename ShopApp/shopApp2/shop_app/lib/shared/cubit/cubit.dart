import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/settings_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../models/favorites_model.dart';
import '../components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

  bool isDark = false;

  void changeThemeMode({bool? isDarkFromCache}) {
    if (isDarkFromCache != null) {
      isDark = isDarkFromCache;
    } else {
      isDark = !isDark;
    }
    emit(ChangeThemeMode());
  }

  List<Widget> pages = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen()
  ];

  List<BottomNavigationBarItem> categoriesItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  int currentIndx = 0;

  void changeCategory(int indx) {
    currentIndx = indx;
    emit(ChangeCurrentCategory());
  }

  HomeModel? homeContents;
  getHomeProduct() {
    emit(LoadingState());
    DioHelper.getData(HOME, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token
    }).then(
      (value) {
        homeContents = HomeModel.fromJson(value.data);
        for (final i in homeContents!.data.products) {
          currentFavorites[i.id] = i.inFavorite;
        }
        emit(GetHomeProductsSuccessState());
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  FavoritesModel? favorites;

  getFavorites() {
    emit(LoadingState());
    DioHelper.getData(FAVORITES, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token
    }).then(
      (value) {
        favorites = FavoritesModel.fromJson(value.data);

        emit(GetFavoritesSuccessState());
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  Map<int, bool> currentFavorites = {};
  CategoriesModel? categories;
  getCategories() {
    emit(LoadingState());
    DioHelper.getData(CATEGORIES, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
    }).then(
      (value) {
        categories = CategoriesModel.fromJson(value.data);

        emit(GetCategoriesSuccessState());
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  toggleFavoriteProduct(int id) {
    currentFavorites[id] = !currentFavorites[id]!;
    emit(ToggleFavoriteSuccessState());
    DioHelper.postData(FAVORITES, data: {
      'product_id': id
    }, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    }).then(
      (value) {
        if (value.data['status']) {
          emit(ToggleFavoriteSuccessState(msg: value.data['message']));
          getFavorites();
        } else {
          currentFavorites[id] = !currentFavorites[id]!;
          emit(ErrorToggleFavorite(value.data['message']));
        }
      },
    ).catchError((error) {
      currentFavorites[id] = !currentFavorites[id]!;
      emit(ErrorToggleFavorite(error.toString()));
    });
  }

  List searchList = [];
  search() {}

  SettingsModel? settings;
  getSettings() {
    emit(LoadingState());
    DioHelper.getData(SETTINGS, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    }).then(
      (value) {
        settings = SettingsModel.fromJson(value.data);
        emit(GetSettingsSuccess(settings!));
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  logoutUser() {
    DioHelper.postData(LOGOUT, data: {}, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    }).then(
      (value) {
        if (value.data['status']) {
          CacheHelper.removeData('token');
          emit(LogoutSuccessState());
        } else {
          emit(ErrorState('Error in LOGOUT'));
        }
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  update(Map<String, dynamic> data) {
    emit(LoadingUpdateState());
    DioHelper.putData(UPDATEPROFILE, data: data, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    }).then(
      (value) {
        print(value.data);
        settings = SettingsModel.fromJson(value.data);

        if (settings!.status) {
          emit(UpdateSuccessState(settings!));
        } else {
          emit(ErrorState(settings!.msg ?? 'error'));
        }
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }
}
