import 'package:hive/hive.dart';
import 'package:my_food_app/model/recently_recipes_model.dart';

class Boxes
{
  static Box<RecentlyRecipes> getRecently() => Hive.box<RecentlyRecipes>("recentlyRecipes");
}