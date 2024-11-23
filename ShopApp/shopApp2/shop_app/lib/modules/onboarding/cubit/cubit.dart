import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/onboarding/onboarding_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'states.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(InitialState());

  static OnBoardingCubit get(context) {
    return BlocProvider.of(context);
  }

  setIsLastReached(bool isLastReached) {
    isLast = isLastReached;
  }

  Future<void> reachEnd() async {
    bool setOrnot =
        await CacheHelper.saveData(key: 'onBoardingShown', value: true);
    if (setOrnot) {
      emit(ReachEndState());
    } else {
      emit(ErrorState());
    }
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
