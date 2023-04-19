import 'package:flutter/material.dart';
import 'package:tech_task/app/presentation/ingredient_screen.dart';
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(50),
              ),
              Center(
                child: createCustomText(
                    inputText: 'Select Date of Lunch',
                    fontSize: 16.0,
                    weight: FontWeight.w400,
                    textColor: Colors.black),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10.0),
              ),
              GestureDetector(
                onTap: () {
                  selectDate();
                },
                child: Container(
                  key: const ValueKey('date_picker'),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(11),
                      right: getProportionateScreenWidth(14)),
                  height: getProportionateScreenHeight(60),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      createCustomText(
                          inputText: selectedDate,
                          fontSize: 16,
                          weight: FontWeight.w400,
                          textColor: Colors.black),
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black87,
                        size: getProportionateScreenWidth(16),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(400),
              ),
              SizedBox(
                height: getProportionateScreenHeight(60.0),
                width: double.infinity,
                child: ElevatedButton(
                  key: ValueKey('navigateButton'),
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
      ),
    );
  }
}
