import 'package:chat2/modules/login/login_screen.dart';
import 'package:chat2/shared/cubit/cubit.dart';
import 'package:chat2/shared/styles/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'firebase_options.dart';
import 'layout/home_layout.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(320, 657.2),
      builder: (context, child) => BlocProvider(
        create: (context) => HomeCubit(),
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
