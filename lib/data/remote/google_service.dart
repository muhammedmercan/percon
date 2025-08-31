import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        await createUserIfNotExists(user);
        await updateLastLogin(user.uid);
      }

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<void> createUserIfNotExists(User user) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final doc = await userRef.get();

    if (!doc.exists) {
      final now = DateTime.now();
      await userRef.set({
        'fullName': user.displayName ?? '',
        'createdAt': user.metadata.creationTime ?? now,
        'lastLogin': user.metadata.creationTime ?? now,
      });
    }
  }

  Future<void> updateLastLogin(String userId) async {
    await _firestore.collection('users').doc(userId).update({
      'lastLogin': FieldValue.serverTimestamp(),
    });
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Stream<User?> get userChanges => _auth.authStateChanges();

  Future<void> updateLastLoginOnAppStart() async {
    final user = _auth.currentUser;
    if (user != null) {
      await updateLastLogin(user.uid);
    }
  }
}
