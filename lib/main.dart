import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoegameinflutter/Provider/GameProvider.dart';
import 'package:tictactoegameinflutter/screens/game.dart';
import 'Provider/ThemeProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => GameProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tic Tac Toe',
          theme: themeProvider.currentTheme,
          home: const GameScreens(),
        );
      },
    );
  }
}
