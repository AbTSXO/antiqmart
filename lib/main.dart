import 'dart:async';

import '/screens/auth_screen.dart';
import '/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/firebase_options.dart';
import 'screens/intro_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

FirebaseAuth auth = FirebaseAuth.instance.authStateChanges() as FirebaseAuth;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Chat',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(background: Colors.grey),
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        // home: const OnBoardingPage(),
        // home: StreamBuilder<User?>(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }

        //     if (snapshot.hasData) {
        //       return const HomeScreen();
        //     } else if (snapshot.hasError) {
        //       return const OnBoardingPage();
        //     }
        //     return const AuthScreen();
        //   },
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              return HomeScreen();
              //  MaterialApp(
              //   initialRoute: OnBoardingPage.id,
              //   routes: {
              //     OnBoardingPage.id: (context) => const OnBoardingPage(),
              //     HomeScreen.id: (context) => const HomeScreen(),
              //   },
              // );
              // return const HomeScreen();
              // return const MessagesScreens();
            }
            return !(snapshot.hasData)
                ? const OnBoardingPage()
                : const AuthScreen();
          },
        )
        // initialRoute: OnBoardingPage.id,
        // routes: {
        //   '/introduction': (context) => const OnBoardingPage(),
        //   '/authentication': (context) => const AuthScreen(),
        // },
        // initialRoute: OnBoardingPage.id,
        // routes: {
        //   StreamBuilder(

        //   // OnBoardingPage.id: (context) => OnBoardingPage(),
        //   // AuthScreen.id: (context) => AuthScreen(),
        //   // HomeScreen.id: (context) => HomeScreen(),
        //  )}
        // home: OnBoardingPage(),
        // home: StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }

        //     if (snapshot.hasData) {
        //       return const HomeScreen();
        //     } else if (snapshot.hasError) {
        //       return const OnBoardingPage();
        //     }
        //     return const AuthScreen();
        //   },
        // )
        );
  }
}
