import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/onboarding/onboarding_screen.dart';

import 'states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(InitialState());

  static OnBoardingCubit get(context) {
    return BlocProvider.of(context);
  }

  isLastReached(bool isLastReached) {
    isLast = isLastReached;
  }

  bool isLast = false;
  final List<BoardItem> boardingItems = const [
    BoardItem(
        image: 'assets/images/shop1.jpg',
        title: 'On Board 1 Title',
        body: 'On Board 1 body'),
    BoardItem(
        image: 'assets/images/shop2.jpg',
        title: 'On Board 2 Title',
        body: 'On Board 2 body'),
    BoardItem(
        image: 'assets/images/shop1.jpg',
        title: 'On Board 3 Title',
        body: 'On Board 3 body'),
  ];
}
