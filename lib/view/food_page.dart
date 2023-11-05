import 'package:flutter/material.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/styles.dart';

class FoodPage extends StatefulWidget
{
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar:AppBar
      (
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: ()=> Navigator.pop(context),
        icon: Icon(Icons.keyboard_arrow_left_rounded, size: 36, color: Styles.whiteColor)),
        backgroundColor: Styles.greenColor,
        title: Text("Berry Banana Breakfast Smoothie",style: Styles().titleWhite),
      ),
      body: _bodyFood(),
    );
  }
}

_bodyFood()
{
  foodInfoIcon(iconName, info) =>
  Column(children:
  [
    Image.asset("images/$iconName.png"),
    const SizedBox(height: 6),
    Text(info,style: Styles().foodPageText),
  ]);

  columnPart(titleText, List<Widget> children) =>
  Column
  (
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Text(titleText, style: Styles().titleBlack),
      const SizedBox(height: 6),
      Column(children: children)
    ],
  );

  List instroList =
  [
    "Take some yogurt in your favorite flavor and add 1 container to your blender.",
    "Add in the berries, banana, and soy milk and blend. Top your glass with a few graham cracker crumbs and serve."
  ];

  nutritionCard() => Container
  (
    width: 112,    
    decoration: BoxDecoration
    (
      color: Styles.darkGreyColor,
      borderRadius: Measures.border16
    ),
    child: Column
    (
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
      [
        Text("Calorie",style: Styles().categorieText),
        Image.asset("images/calories.png"),
        Text("456 Kcal",style: Styles().calorieText),
      ],
    ),
  );

  return SingleChildScrollView
  (
    child: Container
    (
      padding: Measures.all16,
      child: Wrap
      (    
        runSpacing: 16,
        children:
        [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children:
          [
            foodInfoIcon("time", "5 min"),
            foodInfoIcon("healthcare", "64/100"),
            foodInfoIcon("serving", "1 Serving"),
            foodInfoIcon("restaurant", "Vegetarian"),
          ]),
          Divider(color: Styles.greyColor),
          columnPart
          (
            "Summary",
            [
              Text("If you want to add more <b>lacto ovo vegetarian</b> recipes to your recipe box, Berry Banana Breakfast Smoothie might be a recipe you should try. One portion of this dish contains about <b>21g of protein</b>, <b>10g of fat</b>, and a total of <b>457 calories</b>. This recipe serves 1 and costs 2.07 per serving. 689 people have tried and liked this recipe. It works well as a rather inexpensive breakfast. A mixture of banana, graham cracker crumbs, vanilla yogurt, and a handful of other ingredients are all it takes to make this recipe so yummy.",style: Styles().foodPageText),
            ]
          ),
          Divider(color: Styles.greyColor),
          columnPart
          (
            "Ingredients",
            [
              ListView.separated
              (
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) => RichText
                (
                  text: TextSpan
                  (
                    text: "\u2022  ",style: Styles().foodPageBullet,
                    children: [TextSpan(text: "ingredient ${index+1}",style: Styles().foodPageText)]
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 6),
              ),
            ]
          ),
          Divider(color: Styles.greyColor),
          columnPart
          (
            "Instructions",
            [
              ListView.separated
              (
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: instroList.length,
                itemBuilder: (context, index) => RichText
                (
                  text: TextSpan
                  (
                    text: "${index+1}-) ",style: Styles().foodPageBullet,
                    children: [TextSpan(text: instroList[index],style: Styles().foodPageText)]
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(height: 6),
              ),
            ]
          ),
          Divider(color: Styles.greyColor),
          columnPart
          (
            "Nutritients",
            [
              SizedBox
              (
                height: 164,
                child: ListView.separated
                (
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) => nutritionCard(),
                  separatorBuilder: (context, index) => const SizedBox(width: 12),
                ),
              ),
            ]
          ),
        ],
      ),
    ),
  );
}