import 'package:flutter/material.dart';
import 'package:tech_task/app/models/response_model/get_recipe_response_model.dart';
import 'package:tech_task/app/services/get_ingredient_service.dart';
import 'package:tech_task/app/services/get_recipes_services.dart';
import 'package:tech_task/core/size_config.dart';
import '../../core/utils.dart';
import '../../core/widgets/custom_text_widget.dart';
import '../models/response_model/get_ingredient_response_model.dart';

class RecipeScreen extends StatefulWidget {
  final String recipe;
  const RecipeScreen({required this.recipe});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  Future<List<Recipe>> getRecipe(String ingredient) async {
    var result = await GetRecipeService.get(ingredient);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Recipe App'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24.0),
                vertical: getProportionateScreenHeight(15.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: getRecipe(widget.recipe),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'An Error occurred, please try again later'));
                      } else if (!snapshot.hasData) {
                        return Center(
                            child: Text(
                                'No ingredient is available at this time, please try again later'));
                      } else {
                        return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data![index];
                                  String title = data.title.toString();
                                  List<String>? ingredients = data.ingredients;
                                  return buildRecipeContainer(
                                      title: title, ingredients: ingredients);
                                }));
                      }
                    }),
                SizedBox(
                  height: getProportionateScreenHeight(60.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: createCustomText(
                        inputText: 'Thanks',
                        fontSize: 20.0,
                        weight: FontWeight.bold,
                        textColor: Colors.white),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container buildRecipeContainer({
    required String title,
    required List<String>? ingredients,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(10),
          horizontal: getProportionateScreenWidth(10)),
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      height: getProportionateScreenHeight(170),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          Expanded(
              child: ListView.builder(
                  itemCount: ingredients!.length,
                  itemBuilder: (context, index) {
                    var data = ingredients[index].toString();
                    return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(5)),
                        height: getProportionateScreenHeight(25),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(child: Text(data)));
                  }))
        ],
      ),
    );
  }
}
