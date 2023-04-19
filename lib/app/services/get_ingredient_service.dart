import 'package:dio/dio.dart';
import 'dart:convert';

import '../../core/api_endpoints.dart';
import '../models/response_model/get_ingredient_response_model.dart';

class GetIngredientsService {
  static final Dio dio = Dio();
  static Future<List<Ingredient>> get() async {
    final url = ApiEndpoint.getIngredients();

    print(url);

    try {
      var response = await dio.get(
        url,
      );
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((ingredient) => Ingredient.fromJson(ingredient)).toList();
        
       
      }
      else{
        throw Exception('Failed to fetch ingredients');
      }
    } catch (e) {
      if (e is DioError) {}
    }
    throw Exception('Failed to fetch ingredients');
  }
}
