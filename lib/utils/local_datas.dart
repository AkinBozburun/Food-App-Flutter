import 'package:flutter/material.dart';
import 'package:my_food_app/utils/styles.dart';

List categories =
[  
  {
    "icon" : "images/breakfast.png",
    "text" : "Breakfasts",
    "api" : "type=breakfast",
  },
  {
    "icon" : "images/main.png",
    "text" : "Main Courses",
    "api" : "type=main course",
  },
  {
    "icon" : "images/soup.png",
    "text" : "Soups",
    "api" : "type=soup",
  },
  {
    "icon" : "images/dessert.png",
    "text" : "Desserts",
    "api" : "type=dessert",
  },
  {
    "icon" : "images/appetizer.png",
    "text" : "Appetizers",
    "api" : "type=appetizer",
  },
  {
    "icon" : "images/salad.png",
    "text" : "Salads",
    "api" : "type=salad",
  },
];

List sortList =
[
  {
    "text" : "Popularity",
    "api" : "sort=Popularity",
  },
  {
    "text" : "Time",
    "api" : "sort=Time",
  },
  {
    "text" : "Price",
    "api" : "sort=Price",
  },
  {
    "text" : "Healthiness",
    "api" : "sort=Healthiness",
  },
  {
    "text" : "Calories",
    "api" : "sort=Calories",
  },
  {
    "text" : "Protein",
    "api" : "sort=Protein",
  },
  {
    "text" : "Carbohydrates",
    "api" : "sort=Carbohydrates",
  },
];

List dietList =
[
  {
    "text" : "Vegetarian",
    "api" : "diet=Vegetarian",
  },
  {
    "text" : "Gluten Free",
    "api" : "diet=Gluten Free",
  },
  {
    "text" : "Vegan",
    "api" : "diet=Vegan",
  },
  {
    "text" : "Pescetarian",
    "api" : "diet=Pescetarian",
  },
  {
    "text" : "Ketogenic",
    "api" : "diet=Ketogenic",
  },
  {
    "text" : "Paleo",
    "api" : "diet=Paleo",
  },
];

List cuisinesList =
[
  {
    "text" : "Asian",
    "api" : "cuisine=Asian",
  },
  {
    "text" : "American",
    "api" : "cuisine=American",
  },
  {
    "text" : "Mexican",
    "api" : "cuisine=Mexican",
  },
  {
    "text" : "European",
    "api" : "cuisine=European",
  },
  {
    "text" : "İtalian",
    "api" : "cuisine=İtalian",
  },
  {
    "text" : "Nordic",
    "api" : "cuisine=Nordic",
  },
  {
    "text" : "Mediterranean",
    "api" : "cuisine=Mediterranean",
  },
];

Icon backIcon = Icon(Icons.keyboard_arrow_left_rounded,size: 32,color: Styles.whiteColor);