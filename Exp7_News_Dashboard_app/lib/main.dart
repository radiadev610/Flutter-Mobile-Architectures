import 'package:flutter/material.dart';
import 'screens/news_dashboard_screen.dart';
import 'screens/sliver_profile_screen.dart';
import 'screens/travel_dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News & Media Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const NewsDashboardScreen(),
        '/profile': (context) => const SliverProfileScreen(),
        '/travel': (context) => const TravelDashboardScreen(),
      },
    );
  }
}