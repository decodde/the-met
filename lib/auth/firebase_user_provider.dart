import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TheMetFirebaseUser {
  TheMetFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

TheMetFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TheMetFirebaseUser> theMetFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<TheMetFirebaseUser>((user) => currentUser = TheMetFirebaseUser(user));
