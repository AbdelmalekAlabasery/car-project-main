import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/cache/prefs.dart';
import '../../../../core/constants/backend_endpoints.dart';
import '../../../../core/constants/constatnts.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/data_base_service.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../models/user_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  // we take fire base auth service to make auth with firebase
  final FirebaseAuthService firebaseAuthService;
  // we use database service to save user data to cloud firestore
  final DatabaseService databaseService;

  AuthRepoImpl({
    required this.firebaseAuthService,
    required this.databaseService,
  });
  @override
  // create user with email and password and save user data to cloud firestore
  Future<Either<Failure, UserModel>> createUserWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
  }) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel = UserModel(
        uid: user.uid,
        name: userName,
        email: email,
      );
      await addUserData(user: userModel);
      await saveUserData(user: userModel);
      return Right(userModel);
    } on CustomException catch (e) {
      await deleteUser(user);
      return Left(FirebaseAuthFailure(errMessage: e.message));
    }
  }

  // sign in with email and password and get user data from cloud firestore
  @override
  Future<Either<Failure, UserModel>> signinWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel currentUser = await getUserData(uid: user.uid);
      saveUserData(user: currentUser);
      return Right(currentUser);
    } on CustomException catch (e) {
      return Left(FirebaseAuthFailure(errMessage: e.message));
    }
  }

  @override
  // add user data to cloud firestore
  Future addUserData({required UserModel user}) async {
    await databaseService.addData(
      path: BackendEndpoints.kUsers,
      data: user.toMap(),
      documentId: user.uid,
    );
  }

// save user data to cache
  @override
  Future saveUserData({required UserModel user}) async {
    var jsonData = jsonEncode(user.toMap());
    await Prefs.setString(kUserData, jsonData);
  }

// get user data from cloud firestore
  Future<UserModel> getUserData({required String uid}) async {
    var userData = await databaseService.getData(
      path: BackendEndpoints.kUsers,
      docuementId: uid,
    );
    return UserModel.fromJson(userData);
  }

// delete user if there was an excption while creating user
  @override
  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

// sign out
  @override
  Future<void> signOut() async {
    await firebaseAuthService.signOut();
  }
}
