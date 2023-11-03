import 'package:flutter/material.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:my_food_app/view/filter_bottomsheet.dart';

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
      appBar: AppBar
      (
        toolbarHeight: 76,
        backgroundColor: Styles.greenColor,
        elevation: 2,
        leading: IconButton(onPressed: ()=> Navigator.pop(context),
        icon: Icon(Icons.keyboard_arrow_left_rounded, size: 36, color: Styles.whiteColor)),
        title: ListTile
        (          
          title: Text(foodName,style: Styles().titleWhite),
          subtitle: Text("46 Recipes, Vegetarian",style: Styles().foodListSubTitle),
        ),
        actions: const [FilterBottomSheet()],
      ),
      body: _foodList(deviceWidth)
    );
  }
}

_foodList(width)
{
  return ListView.separated
  (
    padding: const EdgeInsets.all(16),
    itemCount: 32,
    itemBuilder: (context, index) => InkWell
    (      
      onTap: (){},
      borderRadius: Measures.border12,
      child: Ink(width: width,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
      [
        ClipRRect
        (
          borderRadius: Measures.border12,
          child: Image.asset("images/cake.jpg",width: 76, height: 76, fit: BoxFit.cover),
        ),
        SizedBox
        (
          width: 240,
          child: Text("Chocolate Silk Pie with Marshmallow Meringue",maxLines: 3,style: Styles().foodListText)
        ),
        Icon(Icons.keyboard_arrow_right_rounded,color: Styles.blackColor, size: 26),
      ])),
    ),
    separatorBuilder: (context, index) => Divider(height: 24, color: Styles.greyColor),
  );
}