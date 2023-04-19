const String base_url =
    'https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev';

class ApiEndpoint {
  ApiEndpoint();

  static String getIngredients() {
    return '$base_url/ingredients';
  }
  static String getRecipes({required String ingredients}) {
    return '$base_url/recipes?ingredients=$ingredients';
  }

  
}
