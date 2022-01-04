import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_details_screen.dart';
import './dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  List<Meal> _avilableMeals = DUMMY_MEALS;
  List<Meal> _favoritsMeal = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      _avilableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (filters['vegeterian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggeleFavorite(String mealId) {
    final existingIndex = _favoritsMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoritsMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritsMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  
  bool _isMealFavotite(String id)
  {
    return _favoritsMeal.any((meal) => meal.id==id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amberAccent,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (cx) => TabsScreen(_favoritsMeal),
        CategoryMealsScreen.routNAme: (cx) => CategoryMealsScreen(
              avilabelMeals: _avilableMeals,
            ),
        MealDetailsScreen.routeName: (cx) => MealDetailsScreen(
              toggelFavoritMeals: _toggeleFavorite,
              isMealFavorite: _isMealFavotite,
            ),
        FiltersScreen.routeName: (cx) => FiltersScreen(
              saveFilters: _setFilters,
              currentFilters: filters,
            ),
      },
    );
  }
}
