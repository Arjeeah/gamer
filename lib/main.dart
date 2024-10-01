import 'package:anime_app/providers/dark_mode_provider.dart';
import 'package:anime_app/providers/game_provider.dart';
import 'package:anime_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GameProvider>(
            create: (context) => GameProvider()),
        ChangeNotifierProvider<DarkModeProvider>(
            create: (context) => DarkModeProvider()..getmode())
      ],
      child:
          Consumer<DarkModeProvider>(builder: (context, darkmodeconsumer, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor:
                darkmodeconsumer.isdark ? Colors.black : Colors.white,
            appBarTheme: AppBarTheme(
                backgroundColor:
                    darkmodeconsumer.isdark ? Colors.black : Colors.white),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor:
                    darkmodeconsumer.isdark ? Colors.black : Colors.white,
                unselectedItemColor:
                    darkmodeconsumer.isdark ? Colors.white : Colors.black),
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}
