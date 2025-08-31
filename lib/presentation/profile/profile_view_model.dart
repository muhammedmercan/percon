import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percon/domain/repositories/auth_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  User? _user;
  User? get user => _user;

  ProfileViewModel(this._authRepository) {
    _authRepository.userChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  String formatDate(DateTime? date, AppLocalizations l10n) {
    if (date == null) return l10n.unknown;

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return l10n.today;
    } else if (difference.inDays == 1) {
      return l10n.yesterday;
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${l10n.daysAgo}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String getAccountCreationDate(AppLocalizations l10n) {
    return formatDate(_user?.metadata.creationTime, l10n);
  }

  String getLastSignInDate(AppLocalizations l10n) {
    return formatDate(_user?.metadata.lastSignInTime, l10n);
  }

  String getUserDisplayName(AppLocalizations l10n) {
    return _user?.displayName ?? l10n.user;
  }

  String getUserEmail(AppLocalizations l10n) {
    return _user?.email ?? l10n.email;
  }

  String? getUserPhotoURL() {
    return _user?.photoURL;
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
