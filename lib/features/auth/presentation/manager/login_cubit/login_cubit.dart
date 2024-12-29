import 'package:car_project/features/auth/data/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit(this.authRepo) : super(LoginCubitInitial());

  final AuthRepo authRepo;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    // send loading state
    emit(LoginCubitLoading());
    final result = await authRepo.signinWithEmailAndPassword(email, password);
    result.fold(
      // send error state
      (failure) => emit(LoginCubitError(failure.errMessage)),
      // send success state
      (user) => emit(LoginCubitSuccess(userModel: user)),
    );
  }
}
