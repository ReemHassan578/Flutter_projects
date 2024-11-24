abstract class AppStates {}

class InitialState extends AppStates {}

class ChangeThemeMode extends AppStates {}

class ChangeCurrentCategory extends AppStates {}

class LoadingState extends AppStates {}

class GetHomeProductsSuccessState extends AppStates {}

class GetCategoriesSuccessState extends AppStates {}

class GetFavoritesSuccessState extends AppStates {}

class ToggleFavoriteSuccessState extends AppStates {
  final String? msg;
  ToggleFavoriteSuccessState({this.msg});
}

class ErrorToggleFavorite extends AppStates {
  final String error;
  ErrorToggleFavorite(this.error);
}
class LoadingToggleFavorite extends AppStates {

}
class ErrorState extends AppStates {
  final String error;
  ErrorState(this.error);
}
