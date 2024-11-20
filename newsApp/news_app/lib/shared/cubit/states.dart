abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeBottomState extends AppStates {}

class GetBusinessDataSuccessState extends AppStates {}

class GetScienceDataSuccessState extends AppStates {}

class GetSportsDataSuccessState extends AppStates {}

class DataLoadingState extends AppStates {}

class DataErrorState extends AppStates {
  final String e;
  DataErrorState(this.e);
}

class ChangeThemeModeState extends AppStates {}

class GetSearchDataSuccessState extends AppStates {}
