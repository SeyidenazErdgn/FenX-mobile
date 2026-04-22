import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FenXApp());
}

class FenXApp extends StatelessWidget {
  const FenXApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FenX Sözlük',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6), // Canlı Mor / Violet
          primary: const Color(0xFF8B5CF6),
          secondary: const Color(0xFFC084FC),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F3FF), // Çok hafif mor arkaplan
        fontFamily: 'Roboto', 
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B5CF6),
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black26,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
