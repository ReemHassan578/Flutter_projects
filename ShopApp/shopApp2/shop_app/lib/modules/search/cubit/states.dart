abstract class SearchStates {}

class InitialSearchState extends SearchStates {}

class ErrorSearchState extends SearchStates {
  final String error;
  ErrorSearchState(this.error);
}

class LoadingSearchState extends SearchStates {}

class SuccussSearchState extends SearchStates {}
