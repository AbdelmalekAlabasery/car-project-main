import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';
// بقول فيها ايه اللي بيحصل بس مش بقول بيحصل ازاي
abstract class AuthRepo {
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> signinWithEmailAndPassword(
      String email, String password);
  // add user data to database == cloud firestore
  Future addUserData({required UserModel user});
  // cache user data to shared preferences == local data base
  Future saveUserData({required UserModel user});
  // delete user data from database if there was an error while creating new user
  Future<void> deleteUser(User? user);
  // signout from firebase
  Future<void> signOut();
}

