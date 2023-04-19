import 'package:dio/dio.dart';
import 'package:tech_task/app/models/response_model/get_recipe_response_model.dart';
import 'dart:convert';

import '../../core/api_endpoints.dart';
import '../models/response_model/get_ingredient_response_model.dart';

class GetRecipeService {
  static final Dio dio = Dio();
  static Future<List<Recipe>> get(String ingredient) async {
    final url = ApiEndpoint.getRecipes(ingredients: ingredient);

    try {
      var response = await dio.get(
        url,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((recipe) => Recipe.fromJson(recipe)).toList();
      } else {
        throw Exception('Failed to fetch ingredients');
      }
    } catch (e) {
      if (e is DioError) {}
    }
    throw Exception('Failed to fetch ingredients');
  }
}
