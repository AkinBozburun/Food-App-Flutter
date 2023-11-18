import 'package:flutter/material.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:my_food_app/view/filter_bottomsheet.dart';
import 'package:my_food_app/view/food_page.dart';
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
    final provider = Provider.of<DataProviders>(context,listen: false);
    
    controller.addListener(()
    {
      if(controller.position.maxScrollExtent == controller.offset)
      {
        provider.extendList();
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
      bottomNavigationBar: _bottomBar(context)
    );
  }
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
      subtitle: provider.showSelectedItems()[0] == "" && provider.showSelectedItems()[1] == "" && provider.showSelectedItems()[2] == "" ? 
      null : Text
      (
        "${provider.showSelectedItems()[0]} ${provider.showSelectedItems()[1]} ${provider.showSelectedItems()[2]}",
        maxLines: 2, style: Styles().foodListSubTitle
      ),
    ),
    actions:
    [
      const FilterBottomSheet(),
      IconButton
      (
        onPressed: ()=> provider.listOrGrid(),
        icon: Icon(provider.isGrid == false? Icons.list_outlined : Icons.grid_on, color: Styles.whiteColor),
      )
    ],
  );
}

_foodList(context, width, controller)
{
  final provider = Provider.of<DataProviders>(context);

  if(provider.recipeList !=[])
  {
    return provider.isGrid == false ?
    ListView.separated
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
              subtitle: provider.recipeList[index].nutrition == null ? null : 
              Text
              (
               "${provider.recipeList[index].nutrition!.nutrients[0].name} : ${provider.recipeList[index].nutrition!.nutrients[0].amount.toInt()} ${provider.recipeList[index].nutrition!.nutrients[0].unit}",
               style: Styles().foodListSubText
              ),
            )
          ),
          Icon(Icons.keyboard_arrow_right_rounded,color: Styles.blackColor, size: 26),
        ])),
      ),
      separatorBuilder: (context, index) => Divider(height: 24, color: Styles.greyColor))
    : GridView.builder
    (
      padding: Measures.all16,
      itemCount: provider.recipeList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
      (
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 80/100
      ),
      itemBuilder: (context, index) => GestureDetector
      (
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FoodPage())),
        child: Container
        (
          decoration: BoxDecoration
          (
            color: Styles.greyColor,
            borderRadius: Measures.border16
          ),
          child: Column
          (
            children:
            [
              ClipRRect
              (
                borderRadius: BorderRadius.only(topLeft: Measures.radius16,topRight: Measures.radius16),
                child: Image.network(provider.recipeList[index].image, fit: BoxFit.cover),
              ),
              ListTile
              (
                title: Text
                (
                  provider.recipeList[index].title, style: Styles().foodListText,
                  maxLines: provider.recipeList[index].nutrition == null ? 3 : 2, overflow: TextOverflow.ellipsis,
                ),
                subtitle: provider.recipeList[index].nutrition == null ? null : Text
                (
                  "${provider.recipeList[index].nutrition!.nutrients[0].name} : ${provider.recipeList[index].nutrition!.nutrients[0].amount.toInt()} ${provider.recipeList[index].nutrition!.nutrients[0].unit}",
                  style: Styles().foodListSubText
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  else
  {
    return Center(child: CircularProgressIndicator(color: Styles.greenColor));
  }
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