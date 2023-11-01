import 'package:flutter/material.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:my_food_app/view/filter_bottomsheet.dart';

class SearchPage extends StatelessWidget
{
  final String foodName;

  const SearchPage({super.key, required this.foodName});

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
      body: _foodList()
    );
  }
}

_foodList()
{
  return ListView.separated
  (
    padding: const EdgeInsets.all(16),
    itemCount: 32,
    itemBuilder: (context, index) => ListTile
    (
      onTap: (){},
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      title: Text("Chocolate Silk Pie with Marshmallow Meringue",style: Styles().foodListText),
      leading: Image.asset("images/cake.jpg"),
      trailing: Icon(Icons.keyboard_arrow_right_rounded,color: Styles.blackColor),
    ),
    separatorBuilder: (context, index) => Divider(color: Styles.greyColor)
  );
}