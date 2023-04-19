class Ingredient {
  final String? title;
  final String? useBy;

  Ingredient({this.title, this.useBy});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      title: json['title'],
      useBy: json['use-by'],
    );
  }
}
