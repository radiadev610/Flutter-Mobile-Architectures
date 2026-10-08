import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/booking_provider.dart';
import 'providers/event_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/event_list_screen.dart';
import 'services/notification_service.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: const EventHubApp(),
    ),
  );
}

class EventHubApp extends StatefulWidget {
  const EventHubApp({super.key});

  @override
  State<EventHubApp> createState() => _EventHubAppState();
}

class _EventHubAppState extends State<EventHubApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthProvider>().checkSession();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return MaterialApp(
      title: 'EventHub App',
      scaffoldMessengerKey: NotificationService.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: auth.isAuthenticated ? const EventListScreen() : const AuthScreen(),
    );
  }
}