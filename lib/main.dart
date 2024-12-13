
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/enter_code_screen.dart';
import 'screens/share_code_screen.dart';
import 'screens/movie_choices_screen.dart';
import 'utils/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Night',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/enter_code': (context) => const EnterCodeScreen(),
        '/share_code': (context) => const ShareCodeScreen(),
        '/movie_choices': (context) => const MovieChoicesScreen(),
      },
    );
  }
}