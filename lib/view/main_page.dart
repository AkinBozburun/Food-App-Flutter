import 'package:flutter/material.dart';
import 'package:my_food_app/utils/categorie_datas.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/styles.dart';

class MainPage extends StatefulWidget
{
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
{
  @override
  Widget build(BuildContext context)
  {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold
    (
      backgroundColor: Styles.greenColor,
      appBar: AppBar
      (
        toolbarHeight: height*0.24,
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
                decoration: InputDecoration
                (
                  icon: const Icon(Icons.search_rounded),
                  iconColor: Colors.black38,
                  contentPadding: const EdgeInsets.all(4),
                  hintText: "Search",
                  border: InputBorder.none,
                  hintStyle: Styles().searchBarHintText,
                ),
                onChanged: (value){},            
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView
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
              Container
              (
                padding: const EdgeInsets.symmetric(vertical: 16),
                height:height*0.8,
                child: ListView
                (
                  children:
                  [
                    _categories(),
                    _recentlyRecipes(width),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_categories()
{
  return Container
  (
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Text("Categories",style: Styles().subTitleBlack),
        const SizedBox(height: 12),
        SizedBox
        (
          height: 340,
          child: GridView.builder
          (            
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
            (
              crossAxisCount: 3, childAspectRatio: 4/5,
              mainAxisSpacing: 16, crossAxisSpacing: 12
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) => Container
            (
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration
              (
                borderRadius: Measures.border16,
                color: Styles.greyColor,
              ),
              child: Column
              (
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
      ],
    ),
  );
}

_recentlyRecipes(width)
{
  return Container
  (
    padding: const EdgeInsets.only(left: 16),
    margin: const EdgeInsets.only(bottom: 64),
    child: Column
    (
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Text("Recently", style: Styles().subTitleBlack),
        const SizedBox(height: 12),
        SizedBox
        (
          height: 192,
          child: ListView.separated
          (
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) => Container
            (
              padding: const EdgeInsets.all(20),
              width: width*0.3,
              decoration: BoxDecoration
              (
                color: Styles.greyColor,
                borderRadius: Measures.border16
              ),
              child: Image.asset("images/dessert.png"),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 12),
          ),
        ),
      ],
    ),
  );
}