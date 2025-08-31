import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Stream<User?> get userChanges;
  Future<void> signInWithGoogle();
  Future<void> signOut();
  Future<void> updateLastLoginOnAppStart();
}
