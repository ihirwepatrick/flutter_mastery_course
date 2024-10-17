import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/models.dart';
import 'user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final useCollections = FirebaseFirestore.instance.collection('users');
  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
@override
  // TODO: implement user
  Stream<MyUser> get user {
    return _firebaseAuth.authStateChanges().flatMap(firebaseUser) async* {
      if (firebaseUser == null) {
        yield MyUser.empty;
      } else {
      yield await useCollections.doc(firebaseUser.uid).get().then((value) =>MyUser.fromEntity(MyUserEntity.fromDocument(value.data)()!));
       }
    }; 
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> setUserData(user) {
    // TODO: implement setUserData
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

 @override
Future<MyUser> signUp(MyUser myUser, String password) async {
  // TODO: implement signUp
  throw UnimplementedError();
}
}
