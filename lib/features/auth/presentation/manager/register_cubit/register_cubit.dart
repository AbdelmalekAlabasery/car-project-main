import 'package:car_project/features/auth/data/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_cubit_state.dart';

class RegisterCubit extends Cubit<RegisterCubitState> {
  RegisterCubit(this.authRepo) : super(RegisterCubitInitial());
  final AuthRepo authRepo;

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    // send loading state
    emit(RegisterCubitLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
      userName: name,
    );
    result.fold(
      // send error state
      (failure) => emit(RegisterCubitError(failure.errMessage)),
      // send success state
      (user) => emit(RegisterCubitSuccess(userModel: user)),
    );
  }
}
