import 'package:flutter/material.dart';
import '../models/meal.dart';
import 'package:meal_app/widget/meals_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routNAme = '/category-meals';

  final List<Meal> avilabelMeals;
  CategoryMealsScreen({
    this.avilabelMeals,
  });
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var loadIniData = false;

  @override
  void didChangeDependencies() {
    if (!loadIniData) {
      final routArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryID = routArgs['id'];
      categoryTitle = routArgs['title'];
      displayedMeals = widget.avilabelMeals.where((meal) {
        return meal.categories.contains(categoryID);
      }).toList();
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (conx, index) {
            return MealsItem(
              id: displayedMeals[index].id,
              imageUrl: displayedMeals[index].imageUrl,
              title: displayedMeals[index].title,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              duration: displayedMeals[index].duration,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
