class Meal {
  String idMeal;
  String strMeal;
  String strMealThumb;

  Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        idMeal: json["idMeal"],
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
      );

  Map<String, dynamic> toJson() => {
        "idMeal": idMeal,
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
      };
}
