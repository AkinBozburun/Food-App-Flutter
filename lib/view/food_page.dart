import 'package:flutter/material.dart';
import 'package:my_food_app/utils/local_datas.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget
{
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage>
{
  @override
  void initState()
  {
    Provider.of<AppBarProviders>(context,listen: false).initscroll();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Styles.whiteColor,
      body: Stack
      (
        children:
        [          
          _bodyFood(context),
          _customAppbar(context),
        ],
      ),
    );
  }
}

_customAppbar(context)
{
  final prov = Provider.of<AppBarProviders>(context);
  return AnimatedContainer
  (
    duration: const Duration(milliseconds: 500),
    curve: Curves.fastLinearToSlowEaseIn,
    color: prov.appBarColor,
    height: prov.height,
    width: MediaQuery.of(context).size.width,
    child: SafeArea
    (
      child: prov.childControl == true ? Row
      (
        children:
        [
          IconButton(onPressed: ()=> Navigator.pop(context),
          icon: ReadyWidgets().backIcon),
          Text("Berry Banana Breakfast Smoothie",style: Styles().titleWhite),
        ],
      ) : const Center(),
    ),
  );
}

_bodyFood(context)
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
      Text(titleText, style: Styles().subTitleBlack),
      const SizedBox(height: 8),
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

  final prov = Provider.of<AppBarProviders>(context,listen: false);

  return SingleChildScrollView
  (
    controller: prov.scrollController,
    child: Column
    (
      children:
      [
        Stack(children:
        [          
          SizedBox(height: 300,width: double.maxFinite, child: Image.asset("images/cake.jpg", fit: BoxFit.cover)),
          SafeArea
          (
            child: GestureDetector
            (
              onTap: () => Navigator.pop(context),
              child: Container
              (
                decoration: BoxDecoration
                (
                  color: Colors.black12,
                  borderRadius: Measures.border12
                ),
                margin: const EdgeInsets.only(left: 16,top: 12),
                height: 42,
                width: 42,
                
                child: Center(child: ReadyWidgets().backIcon),
              ),
            ),
          ),
        ]),
        Container
        (
          margin: Measures.all16,
          child: Wrap
          (
            runSpacing: 16,
            children:
            [
              Container
              (
                margin: const EdgeInsets.only(right: 32),
                child: Text("Berry Banana Breakfast Smoothie",style: Styles().titleBlack)
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children:
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
                    padding: Measures.horizontal0,
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
                    padding: Measures.horizontal0,
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
      ],
    ),
  );
}