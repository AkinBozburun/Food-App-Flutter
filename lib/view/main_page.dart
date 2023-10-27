import 'package:flutter/material.dart';
import 'package:my_food_app/utils/meisures.dart';
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
    return Scaffold
    (
      backgroundColor: Styles.greenColor,
      appBar: AppBar
      (
        toolbarHeight: Meisures.height*0.08,
        backgroundColor: Colors.transparent,        
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
      body: Container
      (
        width: Meisures.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration
        (
          color: Styles.whiteColor,
          borderRadius: BorderRadius.only(topLeft: Meisures.radius16, topRight: Meisures.radius16),
        ),
        child: _categories(),
      ),
    );
  }
}

_categories()
{
  return Column
  (
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Align(alignment: Alignment.center,child: Container(height: 4,width: 36,color: Styles.darkGreyColor)),
      const SizedBox(height: 12),
      Text("Categories",style: Styles().subTitleBlack),
      const SizedBox(height: 12),
      Expanded
      (
        child: GridView.builder
        (
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
          (
            crossAxisCount: 3, childAspectRatio: 4/5,
            mainAxisSpacing: 16, crossAxisSpacing: 12
          ),
          itemCount: 6,
          itemBuilder: (context, index) => Container
          (
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration
            (
              borderRadius: Meisures.border16,
              color: Styles.greyColor,
            ),
            child: Column
            (
              children:
              [
                Image.asset("images/breakfast.png"),
                const SizedBox(height: 12),
                Text("Breakfast",style: Styles().categorieText)
              ],
            ),
          ),
        ),
      ),
    ],
  );
}