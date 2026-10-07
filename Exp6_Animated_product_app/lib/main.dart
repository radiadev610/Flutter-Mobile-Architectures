import 'package:flutter/material.dart';
import 'screens/product_catalog_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/sequential_login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Product App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ProductCatalogScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const SequentialLoginScreen(),
      },
    );
  }
}