import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<AppStates> {
  NewsCubit() : super(InitialState());
  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  int currentPage = 0;
  List business = [];
  List sports = [];
  List science = [];
  List<Widget> pages = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];
  changeBotomNavBar(int value) {
    currentPage = value;

    switch (value) {
      case 0:
        if (business.isEmpty) {
          getBusinessData();
        }
        break;
      case 1:
        if (sports.isEmpty) {
          getSportData();
        }
        break;
      case 2:
        if (science.isEmpty) {
          getScienceData();
        }
        break;
    }
    emit(ChangeBottomState());
  }

  getBusinessData() {
    emit(DataLoadingState());
    DioHelper.getData('v2/top-headlines', {
      'country': 'us',
      'category': 'business',
      'apiKey': 'e3539dfe040445d38735ac585d86f6af'
    }).then(
      (value) {
        if (value.isNotEmpty) {
          business = value;
          emit(GetBusinessDataSuccessState());
          // print(business[0]);
        }
      },
    ).catchError((e) {
      emit(DataErrorState(e.toString()));
    });
    // print(businessData);
  }

  static NewsCubit get(BuildContext cntx) {
    return BlocProvider.of(cntx);
  }

  getScienceData() {
    emit(DataLoadingState());
    DioHelper.getData('v2/top-headlines', {
      'country': 'us',
      'category': 'science',
      'apiKey': 'e3539dfe040445d38735ac585d86f6af'
    }).then(
      (value) {
        if (value.isNotEmpty) {
          science = value;
          emit(GetScienceDataSuccessState());
          // print(business[0]);
        }
      },
    ).catchError((e) {
      emit(DataErrorState(e.toString()));
    });
    // print(businessData);
  }

  getSportData() {
    emit(DataLoadingState());
    DioHelper.getData('v2/top-headlines', {
      'country': 'us',
      'category': 'sports',
      'apiKey': 'e3539dfe040445d38735ac585d86f6af'
    }).then(
      (value) {
        if (value.isNotEmpty) {
          sports = value;
          emit(GetSportsDataSuccessState());
        }
      },
    ).catchError((e) {
      emit(DataErrorState(e.toString()));
    });
    // print(businessData);
  }

  bool isDark = false;
  List search = [];

  getSearchData({String? key, String? typedText}) async {
    emit(DataLoadingState());

    try {
      var list = await DioHelper.getData('v2/everything',
          {key!: typedText, 'apiKey': 'e3539dfe040445d38735ac585d86f6af'});
      if (list.isNotEmpty) {
        search = list;
        emit(GetSearchDataSuccessState());
      }
    } catch (e) {
      emit(DataErrorState(e.toString()));
    }
  }

  changeThemeMode({bool? isDarkFromSP}) async {
    if (isDarkFromSP != null) {
      isDark = isDarkFromSP;
    } else {
      isDark = !isDark;
      await CacheHelper.saveBoolean('isDark', isDark);

      emit(ChangeThemeModeState());
    }
  }
}
