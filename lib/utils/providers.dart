import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_food_app/model/food_recipe_model.dart';
import 'package:my_food_app/model/recipe_list_model.dart';
import 'package:my_food_app/utils/local_datas.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class AppBarProviders extends ChangeNotifier
{
  double height = 0;
  Color appBarColor = Colors.transparent;

  bool childControl = false;
  bool isTriggered = false;
  bool searchMode = false;

  late ScrollController scrollController;

  initscroll()
  {
    scrollController = ScrollController()..addListener(()=>isExpanded());
  }

  isExpanded()
  {
    if(scrollController.hasClients && scrollController.offset > 300)
    {          
      if(isTriggered == false)
      {        
        height = kToolbarHeight+24;
        appBarColor = Styles.greenColor;
        childControl = true;
        notifyListeners();
        isTriggered = !isTriggered;
      }
    }
    if(scrollController.hasClients && scrollController.offset < 300)
    {
      if(isTriggered == true)
      {        
        height = 0;
        appBarColor = Colors.transparent;
        childControl = false;
        notifyListeners();
        isTriggered = !isTriggered;
      }
    }
  }

  disposeAppbar()
  {
    height = 0;
    appBarColor = Colors.transparent;
    childControl = false;
    notifyListeners();
  }

  searchModeSwitch()
  {
    searchMode = !searchMode;
    notifyListeners();
  }

  bool mainBarIsSearching = false;

  mainPageSearchMode()
  {
    mainBarIsSearching = !mainBarIsSearching;
    notifyListeners();
  }
}

class FilterProviders extends ChangeNotifier
{
  List<bool> sortListButton = List.generate(sortList.length, (index) => false);
  List<bool> dietListButton = List.generate(dietList.length, (index) => false);
  List<bool> cuisineListButton = List.generate(cuisinesList.length, (index) => false);

  listItem(listMode, index)
  {    
    if(listMode == "Sort by")
    {
      return sortListButton[index];
    }
    if(listMode == "Diet")
    {
      return dietListButton[index];
    }
    if(listMode == "Cuisine")
    {
      return cuisineListButton[index];
    }
  }

  buttonSwitch(String listTitle, String dataString, int index)
  {
    if(listTitle == "Sort by")
    {
      sortListButton[index] = !sortListButton[index];
      for(var i = 0; i<sortListButton.length; i++)
      {
        if(index != i)
        {
          sortListButton[i] = false;
        }
      }
      selectedSort = sortListButton[index] == true? dataString : "";
    }
    if(listTitle == "Diet")
    {
      dietListButton[index] = !dietListButton[index];
      for(var i = 0; i<dietListButton.length; i++)
      {
        if(index != i)
        {
          dietListButton[i] = false;
        }
      }
      selectedDiet = dietListButton[index] == true? dataString : "";
    }
    if(listTitle == "Cuisine")
    {
      cuisineListButton[index] = !cuisineListButton[index];
      for(var i = 0; i<cuisineListButton.length; i++)
      {
        if(index != i)
        {
          cuisineListButton[i] = false;
        }
      }
      selectedCuisine = cuisineListButton[index] == true? dataString : "";
    }
    notifyListeners();
  }

  clearAllButtons()
  {
    for(var i = 0; i<7; i++)
    {
      if(sortListButton.contains(true))
      {
        sortListButton[i] = false;
      }
      if(dietListButton.contains(true))
      {
        dietListButton[i] = false;
      }
      if(cuisineListButton.contains(true))
      {
        cuisineListButton[i] = false;
      }
    }
    notifyListeners();
    clearSelects();
    
  }

  clearSelects()
  {
    selectedSort = "";
    selectedDiet = "";
    selectedCuisine = "";
  }
}

String? selectedType;
String selectedQuery = "";
String selectedSort = "";
String selectedDiet = "";
String selectedCuisine = "";
bool selectedSortDirection = false;

class DataProviders extends ChangeNotifier
{
  final apiKey = {"x-api-key" : "b3615cad35ab43ee8a6d5892e149ff05"};

  bool isGrid = false;
  int offset = 0;
  int totalResult = 0;
  List<Results>? recipeList;

  late String api;

  fetchListData(String? type, String? query, String? sort, bool? sortDirection, String? diet, String? cuisine) async
  {
    selectedType = type;
    selectedQuery = query ?? "";
    offset = 0;

    sortFix()
    {
      if(selectedSort == "Populars")
      {
        return "Popularity";
      }
      if(selectedSort == "Meta Score")
      {
        return "meta-data";
      }
      else
      {
        return sort;
      }
    }

    String? typeText = type != null? "type=$type" : null;
    String? queryText = query != null? "query=$query" : null;
    String? sortText = sort != null? "sort=${sortFix()}" : null;
    String? dietText = diet != null? "diet=$diet" : null;
    String? cuisineText = cuisine != null? "cuisine=$cuisine" : null;
    String? direction = sortDirection == null || sortDirection == false? "sortDirection=desc": "sortDirection=asc";

    api = "https://api.spoonacular.com/recipes/complexSearch?$typeText&$queryText&$sortText&$direction&$dietText&$cuisineText&addRecipeInformation=true&number=32&offset=";
    
    final connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult != ConnectivityResult.none)
    {
      final data = await http.get(headers: apiKey, Uri.parse(api+offset.toString()));
      final response = Recipes.fromJson(json.decode(data.body));
      totalResult = response.totalResults;
      recipeList = [];    
      recipeList!.addAll(response.results);
      notifyListeners();
    }
  }

  listDirection()
  {
    selectedSortDirection = !selectedSortDirection;
    notifyListeners();
  }
  
  listOrGrid()
  {
    isGrid = !isGrid;
    notifyListeners();
  }
  
  extendList() async
  {
    offset = recipeList!.length;

    final data = await http.get(headers: apiKey, Uri.parse(api+offset.toString()));
    final response = Recipes.fromJson(json.decode(data.body));
    recipeList!.addAll(response.results);
    notifyListeners();
  }
  
  String imageURL = "";
  String title = "";

  bool isPopular = false;

  String readyTime = "";
  String healthScore = "";
  String serving = "";
  String type = "";
  String diet = "";
  String cuisine = "";

  String summary = "";

  List<Ingredients> ingredientsList = [];
  List instructionsList = [];
  List<Nutrients> nutrientsList = [];

  fetchRecipeByID(String id) async
  {
    String api = "https://api.spoonacular.com/recipes/$id/information?includeNutrition=true";

    final connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult != ConnectivityResult.none)
    {
      final data = await http.get(headers: apiKey, Uri.parse(api));
      final response = Food.fromJson(json.decode(data.body));

      imageURL = response.image;
      title = response.title;
      isPopular = response.popular;
      readyTime = response.readyInMinutes.toString();
      healthScore = response.healthScore > 90 || response.healthy == true?  "Very healthy!" : "${response.healthScore}/100";
      serving = response.servings.toString();
      type = response.dishTypes;
      diet = response.diets ?? "General";
      cuisine = response.cuisines ?? "Universal";
      summary = response.summary;
      ingredientsList = response.nutrition.ingredients;
      instructionsList = response.analyzedInstructions.isEmpty? [] : response.analyzedInstructions[0].steps;
      addNutrients(response.nutrition.nutrients);

      notifyListeners();
    }    
  }

  addNutrients(List nutListData)
  {
    nutrientsList = [];
    for(int a=0; a<nutrientsIcons.length; a++)
    {
      for(int i=0; i<nutListData.length; i++)
      {
        if(nutrientsIcons[a]["name"] == nutListData[i].name)
        {
          if(!nutrientsList.contains(nutrientsIcons[a]["name"]))
          {
            nutrientsList.add(nutListData[i]);
          }
        }
      }
    }
  }
  
  showSelectedItems() =>
  [
    selectedSort != ""? selectedSort : "",
    selectedDiet != ""? selectedDiet : "",
    selectedCuisine != ""? selectedCuisine : "",
  ];

  gatherSelectedItems()
  {
    fetchListData(selectedType, selectedQuery, selectedSort, selectedSortDirection, selectedDiet, selectedCuisine);
  }
 }