import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import '../user_repository.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseuser) async* {
      if (firebaseuser == null) {
        yield MyUser.empty;
      } else {
        await userCollection.doc(firebaseuser.uid).get().then((value) =>
            MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
      }
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: myUser.email, password: password);
      myUser.userId = userCredential.user!.uid;

      return myUser;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await userCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}