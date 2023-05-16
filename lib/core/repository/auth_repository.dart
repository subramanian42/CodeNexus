import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:code_nexus/core/model/user_model.dart';

class LogOutFailure implements Exception {}

// This class represents an authentication repository.
class AuthRepository {
// An instance of FirebaseAuth to handle authentication operations.
  final _firebaseAuth = firebase_auth.FirebaseAuth.instance;

// A stream that provides the currently authenticated user.
// It maps the FirebaseUser object to a custom UserModel object.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
// Convert the FirebaseUser to a UserModel object.
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

// This method allows the user to log in using their GitHub account.
// It returns a Future that resolves to a User object, or null if the login fails.
  Future<User?> loginWithGithub() async {
// Sign in with GitHub provider using a popup authentication flow.
    firebase_auth.UserCredential userCredential = await _firebaseAuth
        .signInWithProvider(firebase_auth.GithubAuthProvider());

// Extract the User object from the UserCredential, and convert it to a UserModel object.
// If the user is null, return null; otherwise, convert the user to a UserModel and return it.
    return userCredential.user?.toUser;
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
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
