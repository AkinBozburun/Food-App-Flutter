import 'package:flutter/material.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:my_food_app/view/filter_bottomsheet.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget
{
  final String foodName;
  final double deviceWidth;

  const SearchPage({super.key, required this.foodName, required this.deviceWidth});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: _appbar(foodName, context),
      body: _foodList(context, deviceWidth)
    );
  }
}

_appbar(foodName,context)
{
  final provider = Provider.of<DataProviders>(context);

  return AppBar
  (
    toolbarHeight: 72,
    backgroundColor: Styles.greenColor,
    elevation: 2,
    leading: IconButton(onPressed: ()=> Navigator.pop(context),
    icon: Icon(Icons.keyboard_arrow_left_rounded, size: 36, color: Styles.whiteColor)),
    title: ListTile
    (          
      title: Text(foodName,style: Styles().titleWhite),
      subtitle: Text("${provider.totalResult} Recipes, Vegetarian",style: Styles().foodListSubTitle),
    ),
    actions: const [FilterBottomSheet()],
  );
}

_foodList(context, width)
{
  final provider = Provider.of<DataProviders>(context);

  return ListView.separated
  (
    padding: const EdgeInsets.all(16),
    itemCount: provider.recipeList.length,
    itemBuilder: (context, index) => InkWell
    (      
      onTap: (){},
      borderRadius: Measures.border12,
      child: Ink(width: width,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
      [
        ClipRRect
        (
          borderRadius: Measures.border12,
          child: Image.network(provider.recipeList[index].image,width: 82, height: 82, fit: BoxFit.cover),
        ),
        SizedBox
        (
          width: 240,
          child: Text(provider.recipeList[index].title,maxLines: 3,style: Styles().foodListText),
        ),
        Icon(Icons.keyboard_arrow_right_rounded,color: Styles.blackColor, size: 26),
      ])),
    ),
    separatorBuilder: (context, index) => Divider(height: 24, color: Styles.greyColor),
  );
}