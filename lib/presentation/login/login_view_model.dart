import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percon/domain/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  User? _user;
  User? get user => _user;

  LoginViewModel(this._authRepository) {
    _authRepository.userChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> login() async {
    await _authRepository.signInWithGoogle();
  }

  Future<void> logout() async {
    await _authRepository.signOut();
  }
}
