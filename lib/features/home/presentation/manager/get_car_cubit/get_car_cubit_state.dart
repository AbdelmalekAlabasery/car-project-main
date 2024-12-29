import '../../../data/car_model.dart';

abstract class GetCarCubitState {}
// initial state of the cubit , it occures when the cubit is created and user don't take action with view
class GetCarCubitInitial extends GetCarCubitState {}

class GetCarCubitLoading extends GetCarCubitState {}

class GetCarCubitSuccess extends GetCarCubitState {
  final List<CarModel> cars;

  GetCarCubitSuccess({required this.cars});
}

class GetCarCubitError extends GetCarCubitState {
  final String error;

  GetCarCubitError({required this.error});
}
  