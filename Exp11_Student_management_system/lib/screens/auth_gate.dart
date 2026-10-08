import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/app_user_model.dart';
import '../services/auth_service.dart';
import 'auth_screen.dart';
import 'teacher_dashboard_screen.dart';
import 'student_view_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // Unauthenticated -> Show Login/Register Form
        if (!snapshot.hasData || snapshot.data == null) {
          return const AuthScreen();
        }

        // Authenticated -> Fetch user role from Firestore and route accordingly
        return FutureBuilder<AppUser?>(
          future: authService.getUserProfile(snapshot.data!.uid),
          builder: (context, userSnap) {
            if (userSnap.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            final user = userSnap.data;
            if (user == null) {
              return const AuthScreen();
            }

            // Route to appropriate role interface
            if (user.role == 'teacher') {
              return TeacherDashboardScreen(user: user);
            } else {
              return StudentViewScreen(user: user);
            }
          },
        );
      },
    );
  }
}