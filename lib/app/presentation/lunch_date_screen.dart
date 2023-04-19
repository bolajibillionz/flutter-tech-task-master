import 'package:flutter/material.dart';
import 'package:tech_task/app/presentation/ingredient_screen.dart';
import 'package:tech_task/core/constants.dart';
import 'package:tech_task/core/size_config.dart';
import 'package:tech_task/core/widgets/custom_text_widget.dart';

class ChooseLunchDateScreen extends StatefulWidget {
  const ChooseLunchDateScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLunchDateScreen> createState() => _ChooseLunchDateScreenState();
}

class _ChooseLunchDateScreenState extends State<ChooseLunchDateScreen> {
  DateTime _selectedLunchDate = DateTime.now();
  String selectedDate = '';

  void selectDate() {
    showDatePicker(
            context: context,
            initialDate: _selectedLunchDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(2099))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedLunchDate = pickedDate.toLocal();
        String _day = _selectedLunchDate.day.toString();
        String _month = _selectedLunchDate.month.toString();
        String _year = _selectedLunchDate.year.toString();
        selectedDate =
            '${_day.padLeft(2, '0')} / ${_month.padLeft(2, '0')} / ${_year.padLeft(2, '0')}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    String _day = _selectedLunchDate.day.toString();
    String _month = _selectedLunchDate.month.toString();
    String _year = _selectedLunchDate.year.toString();
    selectedDate =
        '${_day.padLeft(2, '0')} / ${_month.padLeft(2, '0')} / ${_year.padLeft(2, '0')}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe App'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(24.0),
            vertical: getProportionateScreenHeight(15.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createCustomText(
                inputText: 'Kindly Select the Date of your Lunch',
                fontSize: 16.0,
                weight: FontWeight.w400,
                textColor: Palette.blackColor),
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            GestureDetector(
              onTap: () {
                selectDate();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(11),
                    right: getProportionateScreenWidth(14)),
                height: getProportionateScreenHeight(60),
                decoration: BoxDecoration(
                    color: Palette.textFieldColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    createCustomText(
                        inputText: selectedDate,
                        fontSize: 16,
                        weight: FontWeight.w400,
                        textColor: Palette.blackColor),
                    Icon(
                      Icons.calendar_month_outlined,
                      color: Palette.textFormFieldTextColor,
                      size: getProportionateScreenWidth(16),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(200),
            ),
            SizedBox(
              height: getProportionateScreenHeight(60.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              IngredientScreen(lunchDate: _selectedLunchDate)));
                },
                child: createCustomText(
                    inputText: 'Get Ingredient',
                    fontSize: 20.0,
                    weight: FontWeight.bold,
                    textColor: Palette.whiteColor),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Palette.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
