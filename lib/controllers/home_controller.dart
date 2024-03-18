import 'package:tugas1_chapter5/models/meal_model.dart';
import 'package:tugas1_chapter5/providers/meal_provider.dart';
import 'package:tugas1_chapter5/models/restaurant_model.dart';
import 'package:tugas1_chapter5/providers/restaurant_provider.dart';

class HomeController {
  Future<List<Meal>> getMealsByCategory(String category) async {
    final data = await MealsProvider().getMealsByCategory(category);
    return data;
  }

  Future<RestaurantModel> getRestaurants() async {
    return await RestaurantsProviders().getRestaurants();
  }
}
