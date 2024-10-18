import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/models.dart';
import 'user_repo.dart';
import 'entities/entities.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollections = FirebaseFirestore.instance.collection('users');
  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  @override
  // TODO: implement user
  Stream<MyUser> get user {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return MyUser.empty;
      } else {
        // Fetch the user data from Firestore
        var documentSnapshot = await userCollections.doc(firebaseUser.uid).get();
        var userData = documentSnapshot.data();

        // Check if userData is not null and convert it to a MyUser instance
        if (userData != null) {
          return MyUser.fromEntity(MyUserEntity.fromDocument(userData));
        } else {
          // If the document does not exist, return MyUser.empty
          return MyUser.empty;
        }
      }
    });
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    
    
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);
      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<void> logOut() async{
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async{
    try {
      await userCollections.doc(myUser.userId).set(myUser.toEntity().toDocument());
    } catch (e) {
      throw (e.toString());
    }
  }
  

  @override
  Future<void> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }
}
