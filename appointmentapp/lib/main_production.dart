import 'package:appointmentapp/core/helpers/extensions.dart';
import 'package:appointmentapp/core/routing/app_router.dart';
import 'package:appointmentapp/doc_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/helpers/constants.dart';
import 'core/helpers/shared_preferences_helper.dart';
import 'firebase_options.dart';
import 'core/di/dependency_injection.dart';
import 'core/helpers/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   Bloc.observer = MyBlocObserver();
  await SharedPreferencesHelper.initSharedPref();
       setupGetIt();
 await checkIfUserLogedIn();

  // not required in firebase app distribution
  // await Firebase.initializeApp(
  // options: DefaultFirebaseOptions.currentPlatform,
  //);
  await ScreenUtil.ensureScreenSize();
  runApp(DocApp(appRouter: AppRouter()));
}

Future<void> checkIfUserLogedIn() async {
  final userToken =
     await SharedPreferencesHelper.getSecuredString(SharedPreferencesKeys.userToken);
  if (userToken.isNullOrEmpty()) {
    isUserLogin = false;
  } else {
    isUserLogin = true;
  }
}
