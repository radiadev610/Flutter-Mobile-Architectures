import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of auth state changes (restricts unauthenticated access)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  // Registration: Creates auth credential and saves role profile in Firestore
  Future<AppUser> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final appUser = AppUser(
      uid: cred.user!.uid,
      email: email.trim(),
      name: name.trim(),
      role: role,
    );

    await _db.collection('users').doc(cred.user!.uid).set(appUser.toMap());
    return appUser;
  }

  // Email / Password Login
  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  // Fetch role for currently logged in user
  Future<AppUser?> getUserProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return AppUser.fromMap(doc.data()!, uid);
    }
    return null;
  }

  // Post-Experiment Task 1: Password reset
  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  // Logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}