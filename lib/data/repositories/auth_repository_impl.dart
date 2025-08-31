import 'package:firebase_auth/firebase_auth.dart';
import 'package:percon/data/remote/google_service.dart';
import 'package:percon/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleService _service;

  AuthRepositoryImpl({GoogleService? service})
      : _service = service ?? GoogleService();

  @override
  Stream<User?> get userChanges => _service.userChanges;

  @override
  Future<void> signInWithGoogle() async {
    await _service.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    await _service.signOut();
  }

  @override
  Future<void> updateLastLoginOnAppStart() async {
    await _service.updateLastLoginOnAppStart();
  }
}
