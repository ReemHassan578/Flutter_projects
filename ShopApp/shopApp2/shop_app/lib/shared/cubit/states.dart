abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeThemeMode extends AppStates {}

class ChangeCurrentCategory extends AppStates {}

class LoadingState extends AppStates {}

class GetHomeProductsSuccessState extends AppStates {}

class GetCategoriesSuccessState extends AppStates {}

class ErrorState extends AppStates {
  final String error;
  ErrorState(this.error);
}
