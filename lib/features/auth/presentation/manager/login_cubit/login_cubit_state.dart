import '../../../data/models/user_model.dart';

abstract class LoginCubitState {}

// initial state of the cubit , it occures when the cubit is created and user don't take action with view
class LoginCubitInitial extends LoginCubitState {}

class LoginCubitError extends LoginCubitState {
  String errorMessage;
  LoginCubitError(this.errorMessage);
}

class LoginCubitSuccess extends LoginCubitState {
  UserModel userModel;
  LoginCubitSuccess({required this.userModel});
}

class LoginCubitLoading extends LoginCubitState {}
