import 'package:get/get.dart';
import 'package:tugas1_chapter5/models/meal_model.dart';

class MealsProvider extends GetConnect {
  Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await get(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
    if (response.status.hasError) {
      throw Exception(response.statusText!);
    } else {
      final meals = List<Map<String, dynamic>>.from(response.body['meals']);
      return meals.map((meal) => Meal.fromJson(meal)).toList();
    }
  }
}
