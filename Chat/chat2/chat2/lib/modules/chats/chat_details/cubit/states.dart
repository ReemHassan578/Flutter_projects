abstract class ChatDetailsStates {}

class InitailState extends ChatDetailsStates {}

class GetChatsSuccessState extends ChatDetailsStates {}

class AddMessageSuccessState extends ChatDetailsStates {}

class PickImageSuccessState extends ChatDetailsStates {}

class DeletePickedImageSuccessState extends ChatDetailsStates {}

class SendPickedImageSuccessState extends ChatDetailsStates {}

class ErrorState extends ChatDetailsStates {}
