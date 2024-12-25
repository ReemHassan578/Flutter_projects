import 'package:chat2/modules/login/cubit/cubit.dart';
import 'package:chat2/modules/register/cubit/cubit.dart';

import 'modules/chats/chat_details/cubit/cubit.dart';
import 'modules/login/login_screen.dart';
import 'shared/cubit/cubit.dart';
import 'shared/netwok/remote/fcm_helper.dart';
import 'shared/styles/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';
import 'layout/home_layout.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';

final ValueNotifier<int> notificationCountNotifier = ValueNotifier<int>(0);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  _incrementNotificationCount();
}

void _incrementNotificationCount() async {
  notificationCountNotifier.value += 1;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FcmHelper.getGoogleAccessToken();
  // foreground fcm
  FirebaseMessaging.onMessage.listen(
    (event) {
      _incrementNotificationCount();
    },
  );

  //  when pressed on notification in background
  FirebaseMessaging.onMessageOpenedApp.listen(
    (event) {
      print(event.data.toString());
    },
  );

  // backgroung fcm
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(320, 657.2),
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
          BlocProvider(
            create: (context) => ChatDetailsCubit(),
          ),
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => RegisterCubit(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          theme: lightTheme,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData) {
                uId = snapshot.data!.uid;
                HomeCubit.get(context).getUserData();

                return const HomeScreen();
              }
              uId = null;

              return LoginScreen();
            },
          ),
        ),
      ),
    );
  }
}
