import 'package:flutter/material.dart';
import 'package:my_food_app/utils/styles.dart';

class AppBarProviders extends ChangeNotifier
{
  double height = 0;
  Color appBarColor = Colors.transparent;
  bool childControl = false;

  bool isTriggered = true;

  ScrollController scrollController = ScrollController();

  initscroll()
  {
    scrollController.addListener(()=>isExpanded());
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
        height = 24;
        appBarColor = Colors.transparent;
        childControl = false;
        notifyListeners();
        isTriggered = !isTriggered;
      }
    }
  }
}