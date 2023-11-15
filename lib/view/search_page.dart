import 'package:flutter/material.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:my_food_app/view/filter_bottomsheet.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget
{
  final String foodName;
  final double deviceWidth;

  const SearchPage({super.key, required this.foodName, required this.deviceWidth});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
{
  final controller = ScrollController();

  @override
  void initState()
  {
    controller.addListener(()
    {
      if(controller.position.maxScrollExtent == controller.offset)
      {
        print("son");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: _appbar(widget.foodName, context),
      body: _foodList(context, widget.deviceWidth, controller)
    );
  }
}

_appbar(foodName,context)
{
  final provider = Provider.of<DataProviders>(context);

  return AppBar
  (
    toolbarHeight: 76,
    backgroundColor: Styles.greenColor,
    elevation: 2,
    leading: IconButton(onPressed: ()=> Navigator.pop(context),
    icon: Icon(Icons.keyboard_arrow_left_rounded, size: 36, color: Styles.whiteColor)),
    title: ListTile
    (
      title: Text(foodName,style: Styles().titleWhite),
      subtitle: Text
      (
        "${provider.showSelectedItems()[0]} ${provider.showSelectedItems()[1]} ${provider.showSelectedItems()[2]} ${provider.totalResult} Recipe",
        maxLines: 2, style: Styles().foodListSubTitle
      ),
    ),
    actions: const [FilterBottomSheet()],
  );
}

_foodList(context, width, controller)
{
  final provider = Provider.of<DataProviders>(context);

  return ListView.separated
  (
    controller: controller,
    padding: const EdgeInsets.all(16),
    itemCount: provider.recipeList.length,
    itemBuilder: (context, index) => InkWell
    (
      onTap: (){print(provider.recipeList[index].id);},
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
          width: width*0.65,
          child: ListTile
          (
            title: Text(provider.recipeList[index].title, style: Styles().foodListText),
            subtitle: provider.recipeList[index].nutrition == null ? const Center() : 
            Text
            (
             "${provider.recipeList[index].nutrition!.nutrients[0].name} : ${provider.recipeList[index].nutrition!.nutrients[0].amount.toInt()} g",
             style: Styles().foodListSubText
            ),
          )
        ),
        Icon(Icons.keyboard_arrow_right_rounded,color: Styles.blackColor, size: 26),
      ])),
    ),
    separatorBuilder: (context, index) => Divider(height: 24, color: Styles.greyColor),
  );
}