import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'get_pizza_event.dart';
part 'get_pizza_state.dart';

class GetPizzaBloc extends Bloc<GetPizzaEvent, GetPizzaState> {
  final PizzaRepository _pizzaRepository;
  GetPizzaBloc(this._pizzaRepository) : super(GetPizzaInitial()) {
    emit(GetPizzaLoading());
    on<GetPizza>((event, emit) async {
      try {
        List<Pizza> pizzas = await _pizzaRepository.getPizzas();
        emit(GetPizzaSuccess(pizzas: pizzas));
      } catch (e) {
        print(e);
        emit(GetPizzaFailure());
      }
    });
  }
}
