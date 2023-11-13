import 'package:flutter/material.dart';
import 'package:my_food_app/utils/styles.dart';

List categories =
[  
  {
    "icon" : "images/breakfast.png",
    "text" : "Breakfasts",
  },
  {
    "icon" : "images/main.png",
    "text" : "Main Courses",
  },
  {
    "icon" : "images/soup.png",
    "text" : "Soups",
  },
  {
    "icon" : "images/dessert.png",
    "text" : "Desserts",
  },
  {
    "icon" : "images/appetizer.png",
    "text" : "Appetizers",
  },
  {
    "icon" : "images/salad.png",
    "text" : "Salads",
  },
];

List sortList =
[
  {
    "text" : "Popularity"
  },
  {
    "text" : "Time"
  },
  {
    "text" : "Price"
  },
  {
    "text" : "Healthiness"
  },
  {
    "text" : "Calories"
  },
  {
    "text" : "Protein"
  },
  {
    "text" : "Carbohydrates"
  },
];

List dietList =
[
  {
    "text" : "Vegetarian",
  },
  {
    "text" : "Gluten Free",
  },
  {
    "text" : "Vegan",
  },
  {
    "text" : "Pescetarian",
  },
  {
    "text" : "Ketogenic",
  },
  {
    "text" : "Paleo",
  },
];

List cuisinesList =
[
  {
    "text" : "Asian",
  },
  {
    "text" : "American",
  },
  {
    "text" : "Mexican",
  },
  {
    "text" : "European",
  },
  {
    "text" : "İtalian",
  },
  {
    "text" : "Nordic",
  },
  {
    "text" : "Mediterranean",
  },
];

Icon backIcon = Icon(Icons.keyboard_arrow_left_rounded,size: 32,color: Styles.whiteColor);