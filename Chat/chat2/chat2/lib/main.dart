import 'package:chat2/modules/chats/chat_details/cubit/cubit.dart';
import 'package:chat2/modules/login/login_screen.dart';
import 'package:chat2/shared/cubit/cubit.dart';
import 'package:chat2/shared/netwok/remote/fcm_helper.dart';
import 'package:chat2/shared/styles/themes.dart';
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('On Backgroung Message');

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken();

  print(token);
  FcmHelper.getGoogleAccessToken();
  // foreground fcm
  FirebaseMessaging.onMessage.listen(
    (event) {
      print(event.data.toString());
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
              return LoginScreen();
            },
          ),
        ),
      ),
    );
  }
}
