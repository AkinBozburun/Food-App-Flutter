import 'package:flutter/material.dart';
import 'package:my_food_app/utils/local_datas.dart';
import 'package:my_food_app/utils/styles.dart';

class AppBarProviders extends ChangeNotifier
{
  double height = 0;
  Color appBarColor = Colors.transparent;
  bool childControl = false;

  bool isTriggered = true;

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
}

class FilterProviders extends ChangeNotifier
{
  List<bool> sortListButton = List.generate(sortList.length, (index) => false);
  List<bool> dietListButton = List.generate(dietList.length, (index) => false);
  List<bool> cuisinesListButton = List.generate(cuisinesList.length, (index) => false);

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
      return cuisinesListButton[index];
    }
  }

  buttonSwitch(listMode, index)
  {
    if(listMode == "Sort by")
    {
      sortListButton[index] = !sortListButton[index];
      for(var i = 0; i<sortListButton.length; i++)
      {
        if(index != i)
        {
          sortListButton[i] = false;
        }
      }
    }
    if(listMode == "Diet")
    {
      dietListButton[index] = !dietListButton[index];
      for(var i = 0; i<dietListButton.length; i++)
      {
        if(index != i)
        {
          dietListButton[i] = false;
        }
      }
    }
    if(listMode == "Cuisine")
    {
      cuisinesListButton[index] = !cuisinesListButton[index];
      for(var i = 0; i<cuisinesListButton.length; i++)
      {
        if(index != i)
        {
          cuisinesListButton[i] = false;
        }
      }
    }
    notifyListeners();
  }  
}