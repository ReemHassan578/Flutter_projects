abstract class HomeStates {}

class LoadingState extends HomeStates {}

class InitailState extends HomeStates {}

class ErrorState extends HomeStates {
  String error;
  ErrorState(this.error);
}

class RecieveNotificationState extends HomeStates {}

class LoadingSendEmailVerificationState extends HomeStates {}

class SendEmailVerificationSuccessState extends HomeStates {}

class SendEmailVerificationErrorState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {}

class PickProfileImageSuccessState extends HomeStates {}

class PickCoverImageSuccessState extends HomeStates {}

class ChooseImagePostSuccess extends HomeStates {}

class LoadingUpdateState extends HomeStates {}

class ChangeBottomNavigationBarState extends HomeStates {}

class UpdateUserInfo extends HomeStates {}

class AddNewPostState extends HomeStates {}

class PostSuccessState extends HomeStates {}

class RemovePostSuccessState extends HomeStates {}

class GetPostsSuccessState extends HomeStates {}

class ToggleLikePostsSuccessState extends HomeStates {}

class AddNewCommentSuccess extends HomeStates {}

class GetUsersSuccessState extends HomeStates {}
