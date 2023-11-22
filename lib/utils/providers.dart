import 'dart:convert';
import 'package:flutter/material.dart';
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

  String title = "";

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

  searchModeSwitch()
  {
    searchMode = !searchMode;
    notifyListeners();
  }

  setTitle()
  {
    title = selectedQuery!;
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
String? selectedQuery;
String selectedSort = "";
String selectedDiet = "";
String selectedCuisine = "";

class DataProviders extends ChangeNotifier
{

  final apiKey = {"x-api-key" : "b3615cad35ab43ee8a6d5892e149ff05"};

  bool isGrid = false;

  int offset = 0;
  int totalResult = 0;
  List<Results>? recipeList;

  late String api;

  fetchData(String? type, String? query, String? sort, String? diet, String? cuisine) async
  {
    selectedType = type;
    selectedQuery = query;
    offset = 0;

    String? typeText = type != null? "type=$type" : null;
    String? queryText = query != null? "query=$query" : null;
    String? sortText = sort != null? "sort=$sort" : null;
    String? dietText = diet != null? "diet=$diet" : null;
    String? cuisineText = cuisine != null? "cuisine=$cuisine" : null;

    api = "https://api.spoonacular.com/recipes/complexSearch?$typeText&$queryText&$sortText&$dietText&$cuisineText&number=32&offset=";

    final data = await http.get(headers: apiKey, Uri.parse(api+offset.toString()));
    final response = Recipes.fromJson(json.decode(data.body));
    totalResult = response.totalResults;
    recipeList = [];    
    recipeList!.addAll(response.results);
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

  showSelectedItems()
  {
    return [
      selectedSort != ""? selectedSort : "",
      selectedDiet != ""? selectedDiet : "",
      selectedCuisine != ""? selectedCuisine : "",
    ];
  }

  gatherSelectedItems()
  {
    fetchData(selectedType, selectedQuery, selectedSort, selectedDiet, selectedCuisine);
  }

  listOrGrid()
  {
    isGrid = !isGrid;
    notifyListeners();
  }
}