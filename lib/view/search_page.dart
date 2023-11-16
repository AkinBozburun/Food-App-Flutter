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
        Provider.of<DataProviders>(context,listen: false).extendList();
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
      body: _foodList(context, widget.deviceWidth, controller),
      floatingActionButton: _fab(controller),
      bottomNavigationBar: _bottomBar(context)
    );
  }
}

_fab(controller)
{
    return Visibility
    (
      visible: controller.hasClients && controller.offset > 128 ? true : false,
      child: FloatingActionButton.small
      (
        onPressed: ()
        {
          controller.animateTo
          (
            0.0.toDouble(), duration: const Duration(milliseconds: 500), curve: Curves.easeIn,
          );
        },
        backgroundColor: Styles.greenColor,
        child: Icon(Icons.arrow_upward,color: Styles.whiteColor),
      ),
    );
}

_appbar(foodName,context)
{
  final provider = Provider.of<DataProviders>(context);

  return AppBar
  (
    toolbarHeight: 64,
    backgroundColor: Styles.greenColor,
    elevation: 2,
    leading: IconButton(onPressed: ()=> Navigator.pop(context),
    icon: Icon(Icons.keyboard_arrow_left_rounded, size: 36, color: Styles.whiteColor)),
    title: ListTile
    (
      title: Text(foodName,style: Styles().titleWhite),
      subtitle: Text
      (
        "${provider.showSelectedItems()[0]} ${provider.showSelectedItems()[1]} ${provider.showSelectedItems()[2]}",
        maxLines: 2, style: Styles().foodListSubTitle
      ),
    ),
    actions: const [FilterBottomSheet()],
  );
}

_foodList(context, width, controller)
{
  final provider = Provider.of<DataProviders>(context);

  return provider.recipeList !=[] ? ListView.separated
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
  ) : Center(child: CircularProgressIndicator(color: Styles.greenColor));
}

_bottomBar(context)
{
  final provider = Provider.of<DataProviders>(context);

  return Container
  (
    height: 42,
    decoration: BoxDecoration
    (
      color: Styles.whiteColor,
      boxShadow:
      [
        BoxShadow(blurRadius: 6,spreadRadius: 1,color: Styles.darkGreyColor)
      ],
    ),
    child: Center(child: Text("${provider.recipeList.length} of ${provider.totalResult} Recipe",style: Styles().foodListSubText)),
  );
}