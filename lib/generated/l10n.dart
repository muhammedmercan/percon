// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Percon`
  String get appTitle {
    return Intl.message(
      'Percon',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get loginWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Continue with your Google account`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with your Google account',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Home Page`
  String get homePage {
    return Intl.message(
      'Home Page',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Home Page!`
  String get welcomeToHome {
    return Intl.message(
      'Welcome to Home Page!',
      name: 'welcomeToHome',
      desc: '',
      args: [],
    );
  }

  /// `Successfully logged in`
  String get successfullyLoggedIn {
    return Intl.message(
      'Successfully logged in',
      name: 'successfullyLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `User Information`
  String get userInfo {
    return Intl.message(
      'User Information',
      name: 'userInfo',
      desc: '',
      args: [],
    );
  }

  /// `Account Creation Date`
  String get accountCreationDate {
    return Intl.message(
      'Account Creation Date',
      name: 'accountCreationDate',
      desc: '',
      args: [],
    );
  }

  /// `Last Sign In Date`
  String get lastSignInDate {
    return Intl.message(
      'Last Sign In Date',
      name: 'lastSignInDate',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutConfirmation {
    return Intl.message(
      'Logout',
      name: 'logoutConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout from your account?`
  String get logoutConfirmationMessage {
    return Intl.message(
      'Are you sure you want to logout from your account?',
      name: 'logoutConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred while logging out`
  String get logoutError {
    return Intl.message(
      'Error occurred while logging out',
      name: 'logoutError',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Update name, surname and photo`
  String get editProfileSubtitle {
    return Intl.message(
      'Update name, surname and photo',
      name: 'editProfileSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `Password and security settings`
  String get securitySubtitle {
    return Intl.message(
      'Password and security settings',
      name: 'securitySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Notification preferences`
  String get notificationsSubtitle {
    return Intl.message(
      'Notification preferences',
      name: 'notificationsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `This feature is coming soon!`
  String get comingSoon {
    return Intl.message(
      'This feature is coming soon!',
      name: 'comingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message(
      'Yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  /// `days ago`
  String get daysAgo {
    return Intl.message(
      'days ago',
      name: 'daysAgo',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `email@example.com`
  String get email {
    return Intl.message(
      'email@example.com',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get languageSelection {
    return Intl.message(
      'Language',
      name: 'languageSelection',
      desc: '',
      args: [],
    );
  }

  /// `Language changed`
  String get languageChanged {
    return Intl.message(
      'Language changed',
      name: 'languageChanged',
      desc: '',
      args: [],
    );
  }

  /// `Language switching feature coming soon!`
  String get languageFeatureComingSoon {
    return Intl.message(
      'Language switching feature coming soon!',
      name: 'languageFeatureComingSoon',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
