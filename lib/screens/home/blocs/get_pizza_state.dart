part of 'get_pizza_bloc.dart';

sealed class GetPizzaState extends Equatable {
  const GetPizzaState();
}

final class GetPizzaInitial extends GetPizzaState {
  @override
  List<Object> get props => [];
}

final class GetPizzaFailure extends GetPizzaState {
  @override
  List<Object> get props => [];
}

final class GetPizzaLoading extends GetPizzaState {
  @override
  List<Object> get props => [];
}

final class GetPizzaSuccess extends GetPizzaState {
  final List<Pizza> pizzas;

  const GetPizzaSuccess({required this.pizzas});

  @override
  List<Object> get props => [pizzas];
}
