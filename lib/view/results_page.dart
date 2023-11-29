import 'package:flutter/material.dart';
import 'package:my_food_app/main.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:my_food_app/view/filter_bottomsheet.dart';
import 'package:my_food_app/view/food_page.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatefulWidget
{
  final String foodName;
  final double deviceWidth;

  const ResultsPage({super.key, required this.foodName, required this.deviceWidth});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage>
{
  final controller = ScrollController();

  initController()
  {
    final provider =  Provider.of<DataProviders>(context,listen: false);

    controller.addListener(()
    {
      if(controller.position.maxScrollExtent == controller.offset  && provider.offset != provider.totalResult)
      {
        provider.extendList();
      }      
    });
  }

  @override
  void initState()
  {
    Provider.of<AppBarProviders>(context,listen: false).mainBarIsSearching = false;
    initController();
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
  final appBarProv = Provider.of<AppBarProviders>(context);

  FocusNode focus = FocusNode();

  return AppBar
  (
    toolbarHeight: 64,
    backgroundColor: Styles.greenColor,
    elevation: 2,
    leading: IconButton(onPressed: ()=> Navigator.pop(context),
    icon: Icon(Icons.keyboard_arrow_left_rounded, size: 36, color: Styles.whiteColor)),
    title: appBarProv.searchMode == true ?
    TextField
    (
      autofocus: true,
      style: Styles().searchBarInputText,
      enableSuggestions: false,
      cursorColor: Styles.darkGreyColor,
      decoration: InputDecoration
      (
        contentPadding: Measures.all8,
        hintText: "Search for $foodName!",
        border: InputBorder.none,
        hintStyle: Styles().searchBarHintText,
      ),
      onTapOutside:(event) => appBarProv.searchModeSwitch(),
      onSubmitted: (value)
      {
        provider.fetchListData(selectedType, value, selectedSort, selectedSortDirection, selectedDiet, selectedCuisine);
        appBarProv.searchModeSwitch();
      },
    ) :
    ListTile
    (
      onTap: ()
      {
        appBarProv.searchModeSwitch();
        focus.requestFocus();
      },
      title: Text(selectedQuery == "" ? foodName : selectedQuery,style: Styles().titleWhite),
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
      ),
    ],
  );
}

_foodList(context, width, controller)
{
  final provider = Provider.of<DataProviders>(context);

  String subTitle(index)
  {
    if(provider.recipeList![index].nutrition != null)
    {
      return "${provider.recipeList![index].nutrition!.nutrients[0].name} : ${provider.recipeList![index].nutrition!.nutrients[0].amount.toInt()} ${provider.recipeList![index].nutrition!.nutrients[0].unit}";
    }
    else
    {
      if(selectedSort == "Meta Score")
      {
        return "$selectedSort: ${provider.recipeList![index].spoonacularScore.toInt()/10} / 10";
      }
      if(selectedSort == "Healthiness")
      {
        return "Health Score: ${provider.recipeList![index].healthScore}";
      }
      if(selectedSort == "Time")
      {
        return "Ready in ${provider.recipeList![index].readyInMinutes} minutes";
      }
    }
    return "";
  }

  Widget iconBadge(double position, child, index)
  {
    return Positioned(top: position,child: SizedBox(width: 24, height: 24, child: child));
  }

  if(provider.recipeList == null)
  {
    return Center(child: CircularProgressIndicator(color: Styles.greenColor));
  }
  if(provider.totalResult == 0)
  {
    return Center(child: Text("No recipes found",style: Styles().foodListText));
  }
  else
  {
    return provider.isGrid == false ?
    ListView.separated
    (
      controller: controller,
      padding: const EdgeInsets.all(16),
      itemCount: provider.recipeList!.length,
      itemBuilder: (context, index) => InkWell
      (
        onTap: ()
        {
          provider.fetchRecipeByID(provider.recipeList![index].id.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NetCheck(page: FoodPage())));
        },
        borderRadius: Measures.border12,
        child: Ink(width: width,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children:
        [
          Stack
          (
            children:
            [         
              ClipRRect
              (
                borderRadius: Measures.border12,
                child: Image.network(provider.recipeList![index].image,width: 102, height: 102, fit: BoxFit.cover),
              ),
              iconBadge(32,provider.recipeList![index].veryPopular == true ? Image.asset("images/popular-badge.png") : null, index),
              iconBadge(8,provider.recipeList![index].veryHealthy == true ? Image.asset("images/healthcare-badge.png") : null, index),
            ],
          ),
          SizedBox
          (
            width: width*0.5,
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(provider.recipeList![index].title, style: Styles().foodListText),
                Text(subTitle(index),style: Styles().foodListSubText),
              ],
            )
          ),
          Icon(Icons.keyboard_arrow_right_rounded,color: Styles.blackColor),
        ])),
      ),
      separatorBuilder: (context, index) => Divider(height: 24, color: Styles.greyColor)
    )
    : GridView.builder
    (
      controller: controller,
      padding: Measures.all16,
      itemCount: provider.recipeList!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
      (
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 75/100
      ),
      itemBuilder: (context, index) => GestureDetector
      (
        onTap: ()
        {
          provider.fetchRecipeByID(provider.recipeList![index].id.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FoodPage()));
        },
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
              Stack
              (
                children:
                [
                  ClipRRect
                  (
                    borderRadius: BorderRadius.only(topLeft: Measures.radius16,topRight: Measures.radius16),
                    child: Image.network(provider.recipeList![index].image, fit: BoxFit.cover),
                  ),
                  iconBadge(42,provider.recipeList![index].veryPopular == true ? Image.asset("images/popular-badge.png") : null, index),
                  iconBadge(12,provider.recipeList![index].veryHealthy == true ? Image.asset("images/healthcare-badge.png") : null, index),
                ],
              ),
              ListTile
              (
                title: Text
                (
                  provider.recipeList![index].title, style: Styles().foodListText,
                  maxLines: 2, overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(subTitle(index),style: Styles().foodListSubText),
              ),
            ],
          ),
        ),
      ),
    );
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
    child:
    provider.recipeList== null ?
    const Center() :
    Center(child: Text("${provider.recipeList!.length} of ${provider.totalResult} Recipe",style: Styles().foodListSubText)),
  );
}