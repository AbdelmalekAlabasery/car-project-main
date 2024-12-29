import 'package:car_project/features/auth/data/models/user_model.dart';

abstract class RegisterCubitState {}

// initial state of the cubit , it occures when the cubit is created and user don't take action with view
class RegisterCubitInitial extends RegisterCubitState {}

class RegisterCubitLoading extends RegisterCubitState {}

class RegisterCubitSuccess extends RegisterCubitState {
  final UserModel userModel;

  RegisterCubitSuccess({required this.userModel});
}

class RegisterCubitError extends RegisterCubitState {
  final String error;
  RegisterCubitError(this.error);
}
