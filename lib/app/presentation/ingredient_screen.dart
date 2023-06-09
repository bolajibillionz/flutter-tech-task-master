import 'package:flutter/material.dart';
import 'package:tech_task/app/models/response_model/get_recipe_response_model.dart';
import 'package:tech_task/app/presentation/recipe_screen.dart';
import 'package:tech_task/app/services/get_ingredient_service.dart';
import 'package:tech_task/app/services/get_recipes_services.dart';
import 'package:tech_task/core/size_config.dart';
import 'package:tech_task/core/widgets/top_snackbar_widget.dart';
import '../../core/utils.dart';
import '../../core/widgets/custom_text_widget.dart';
import '../models/response_model/get_ingredient_response_model.dart';

class IngredientScreen extends StatefulWidget {
  final DateTime lunchDate;
  const IngredientScreen({required this.lunchDate});

  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  List<String> _selectedIngredients = [];
  Future<List<Ingredient>> getIngredients() async {
    var result = await GetIngredientsService.get();
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
                Text(
                  'Available Ingredients',
                  style: TextStyle(fontSize: getProportionateScreenWidth(24.0)),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                FutureBuilder(
                  key: const ValueKey('future_builder'),
                    future: getIngredients(),
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
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data![index];
                                String title = data.title.toString();
                                String useBy = data.useBy.toString();
                                bool expired = isExpired(
                                    date: useBy, lunchDate: widget.lunchDate);
                                return buildIngredientList(
                                    ingredientExpired: expired,
                                    onPressed: expired
                                        ? () {
                                            warningTopSnackBar(
                                                context: context,
                                                message: 'Expired Ingredient');
                                          }
                                        : () {
                                            _toggleIngredientSelection(title);
                                          },
                                    title: title,
                                    date: useBy);
                              }),
                        );
                      }
                    }),
                SizedBox(
                  height: getProportionateScreenHeight(60.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedIngredients.isEmpty) {
                        warningTopSnackBar(
                            context: context,
                            message: 'No ingredient selected');
                      } else {
                        var recipe = _selectedIngredients.join(',');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RecipeScreen(recipe: recipe)));
                      }
                    },
                    child: createCustomText(
                        inputText: 'Get Recipe',
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

  Padding buildIngredientList(
      {required String title,
      required String date,
      required void Function()? onPressed,
      required bool ingredientExpired}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(0)),
      child: SizedBox(
        // height: getProportionateScreenHeight(100),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                      color: ingredientExpired ? Colors.red : Colors.green))),
          onPressed: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: title.length > 9
                            ? getProportionateScreenWidth(10)
                            : getProportionateScreenWidth(12),
                        color: Colors.black),
                  ),
                  ingredientExpired
                      ? Text(' (expired)',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              color: Colors.red))
                      : SizedBox()
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(15),
              ),
              Row(
                children: [
                  Text(date, style: TextStyle(color: Colors.black)),
                ],
              ),
              ingredientExpired
                  ? SizedBox()
                  : CheckboxListTile(
                      value: _isIngredientSelected(title),
                      activeColor: Colors.green,
                      onChanged: (value) {},
                    ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isIngredientSelected(String ingredientName) {
    return _selectedIngredients.contains(ingredientName);
  }

  void _toggleIngredientSelection(String ingredientName) {
    setState(() {
      if (_isIngredientSelected(ingredientName)) {
        _selectedIngredients.remove(ingredientName);
      } else {
        _selectedIngredients.add(ingredientName);
      }
    });
  }
}
