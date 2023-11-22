import 'package:flutter/material.dart';
import 'package:my_food_app/utils/local_datas.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:my_food_app/view/food_page.dart';
import 'package:my_food_app/view/results_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget
{
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
{
  @override
  Widget build(BuildContext context) => _scaffold(context);
}

_scaffold(context)
{
  final prov = Provider.of<AppBarProviders>(context);
  final dataProv = Provider.of<DataProviders>(context);

  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;

  if(prov.mainBarIsSearching == true)
  {
    return Scaffold
    (
      backgroundColor: Styles.whiteColor,
      appBar: AppBar
      (
        backgroundColor: Styles.greenColor,
        leading: IconButton(onPressed: () => prov.mainPageSearchMode(), icon: ReadyWidgets().backIcon),
        title: TextField
        (
          autofocus: true,
          style: Styles().searchBarInputText,
          enableSuggestions: false,
          cursorColor: Styles.darkGreyColor,
          decoration: InputDecoration
          (
            hintText: "Search for recipes!",
            border: InputBorder.none,
            hintStyle: Styles().searchBarHintText,
          ),
          onSubmitted: (value)
          {
            dataProv.fetchData(null, value, null, null, null);
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ResultsPage(foodName: value, deviceWidth: width)));
          },
        ),
      ),
    );
  }
  else
  {
    return Scaffold
    (
      backgroundColor: Styles.greenColor,
      appBar: _appbar(height, width, context),
      body: SafeArea
      (
        child: SingleChildScrollView
        (
          physics: const NeverScrollableScrollPhysics(),
          child: Container
          (
            height: height,
            width: width,
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration
            (
              color: Styles.whiteColor,
              borderRadius: BorderRadius.only(topLeft: Measures.radius16, topRight: Measures.radius16),
            ),
            child: Column
            (
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Container(height: 4,width: 36,color: Styles.darkGreyColor),  
                const SizedBox(height: 12),            
                Container
                (
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height:height*0.8,
                  child: ListView
                  (
                    children:
                    [
                      _categories(context, width),
                      const SizedBox(height: 24),
                      _recently(width,context),
                      const SizedBox(height: 64),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_appbar(height, width, context)
{
  final prov = Provider.of<AppBarProviders>(context);

  return AppBar
  (
    toolbarHeight: height*0.2,
    backgroundColor: Colors.transparent,
    scrolledUnderElevation: 0,
    title: Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Text("Find Recipes!",style: Styles().titleWhite),
        const SizedBox(height: 12),
        Container
        (
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration
          (
            color: Styles.whiteColor, borderRadius: BorderRadius.circular(36),
            border: Border.all(color: Styles.darkGreyColor)
          ),
          child: TextField
          (
            onTap: () => prov.mainPageSearchMode(),
            decoration: InputDecoration
            (
              icon: const Icon(Icons.search_rounded),
              iconColor: Colors.black38,
              contentPadding: const EdgeInsets.all(4),
              hintText: "Search",
              border: InputBorder.none,
              hintStyle: Styles().searchBarHintText,
            ),
          ),
        ),
      ],
    ),
  );
}

_categories(context,width)
{
  final dataProv = Provider.of<DataProviders>(context);
  final filterProv = Provider.of<FilterProviders>(context);

  return Column
  (
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Text("Categories",style: Styles().subTitleBlack),
      const SizedBox(height: 12),
      SizedBox
      (
        height: 350,
        child: GridView.builder
        (
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
          (
            crossAxisCount: 3, childAspectRatio: 5/7,
            mainAxisSpacing: 16, crossAxisSpacing: 12
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) => InkWell
          (
            onTap: ()
            {
              filterProv.clearAllButtons();
              dataProv.fetchData(categories[index]["text"],null,null,null,null);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
              ResultsPage(foodName: categories[index]["text"], deviceWidth: width)));
            },
            child: Container
            (
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration
              (
                borderRadius: Measures.border16,
                color: Styles.greyColor,
              ),
              child: Column
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Image.asset(categories[index]["icon"]),
                  const SizedBox(height: 12),
                  Text(categories[index]["text"],style: Styles().categorieText),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

_recently(width,context)
{
  return Column
  (
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Text("Recently", style: Styles().subTitleBlack),
      const SizedBox(height: 12),
      SizedBox
      (
        height: 212,
        child: ListView.separated
        (
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) => GestureDetector
          (
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FoodPage())),
            child: Container
            (
              width: width*0.3,
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
                    child: Image.asset("images/cake.jpg",fit: BoxFit.cover,height: 104)
                  ),
                  const SizedBox(height: 6),
                  Container
                  (
                    padding: Measures.horizontal8,
                    child: Column
                    (                    
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text("Super Delicious Cake",style: Styles().recentlyText1),
                        const SizedBox(height: 6),
                        Row(children:
                        [
                          Image.asset("images/cooking.png"),
                          const SizedBox(width: 6),
                          Text("12 Min.", style: Styles().recentlyText2),
                        ]),
                        const SizedBox(height: 6),
                        Row(children:
                        [
                          const Icon(Icons.star_rounded,size: 18),
                          const SizedBox(width: 2),
                          Text("6/10", style: Styles().recentlyText3),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(width: 12),
        ),
      ),
    ],
  );
}