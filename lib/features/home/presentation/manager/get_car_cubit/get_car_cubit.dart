import 'package:car_project/core/services/get_car_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_car_cubit_state.dart';

class GetCarCubit extends Cubit<GetCarCubitState> {
  GetCarCubit() : super(GetCarCubitInitial());
  GetCarService getCarService = GetCarService(
    firestore: FirebaseFirestore.instance,
  );
  Future<void> getCars() async {
    // emit loading state to show loading indicator
    emit(GetCarCubitLoading());
    try {
      // get cars and emit success state
      var cars = await getCarService.getCars();
      emit(GetCarCubitSuccess(cars: cars));
    } catch (e) {
      // emit error state
      emit(GetCarCubitError(error: e.toString()));
    }
  }
}