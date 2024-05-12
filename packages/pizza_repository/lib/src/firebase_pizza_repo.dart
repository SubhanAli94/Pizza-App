import 'package:cloud_firestore/cloud_firestore.dart';
import '../pizza_repository.dart';

class FirebasePizzaRepository extends PizzaRepository {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

  @override
  Future<List<Pizza>> getPizzas() async {
    try {
      return await pizzaCollection.get().then((value) => value.docs
          .map((e) => Pizza.fromEntity(PizzaEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
