import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:code_nexus/core/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class LogOutFailure implements Exception {}

// This class represents an authentication repository.
class AuthRepository {
// An instance of FirebaseAuth to handle authentication operations.
  final _firebaseAuth = firebase_auth.FirebaseAuth.instance;

// A stream that provides the currently authenticated user.
// It maps the FirebaseUser object to a custom UserModel object.
  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
// Convert the FirebaseUser to a UserModel object.
      final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      return user;
    });
  }

// This method allows the user to log in using their GitHub account.
// It returns a Future that resolves to a User object, or null if the login fails.
  Future<UserModel?> loginWithGithub() async {
// Sign in with GitHub provider using a popup authentication flow.
    final prefs = await SharedPreferences.getInstance();
    firebase_auth.UserCredential userCredential = await _firebaseAuth
        .signInWithProvider(firebase_auth.GithubAuthProvider());
    final token = userCredential.credential?.accessToken;

    prefs.setString(Constants.authToken, token ?? "");
// Extract the User object from the UserCredential, and convert it to a UserModel object.
    final user = userCredential.user?.toUser;

// If the user is null, return null; otherwise, convert the user to a UserModel and return it.
    return user;
  }

  UserModel get currentUser {
    return _firebaseAuth.currentUser?.toUser ?? UserModel.empty;
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw LogOutFailure();
    }
  }
}

// This extension adds a method to the User class to convert it into a UserModel.
extension on firebase_auth.User {
// Convert the User object to a UserModel object with specified properties.
  UserModel get toUser {
    return UserModel(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
    );
  }
}
