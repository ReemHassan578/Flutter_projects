import 'package:shop_app/models/settings_model.dart';

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

class GetSettingsSuccess extends AppStates {
  final SettingsModel settings;

  GetSettingsSuccess(this.settings);
}

class LoadingUpdateState extends AppStates {}

class LogoutSuccessState extends AppStates {}

class UpdateSuccessState extends AppStates {
  final SettingsModel update;
  UpdateSuccessState(this.update);
}

class ErrorToggleFavorite extends AppStates {
  final String error;
  ErrorToggleFavorite(this.error);
}

class LoadingToggleFavorite extends AppStates {}

class ErrorState extends AppStates {
  final String error;
  ErrorState(this.error);
}
