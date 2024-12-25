part of 'movies_cubit.dart';

abstract class MoviesStates {}

class MoviesInitialState extends MoviesStates {}

class ErrorState extends MoviesStates {}

class GetMoviesSuccessState extends MoviesStates {}

class ChangeOpacityState extends MoviesStates {}

class GoToDetailsState extends MoviesStates {}
