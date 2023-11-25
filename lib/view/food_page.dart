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
  final provider = Provider.of<DataProviders>(context);

  return AnimatedContainer
  (
    duration: const Duration(milliseconds: 500),
    curve: Curves.fastLinearToSlowEaseIn,
    color: prov.appBarColor,
    height: prov.height,
    width: MediaQuery.of(context).size.width,
    child: SafeArea
    (
      child: prov.childControl == true ? Padding
      (
        padding: const EdgeInsets.only(right: 16),
        child: Row
        (
          children:
          [
            IconButton(onPressed: ()
            {
              prov.disposeAppbar();
              Navigator.pop(context);
            },
            icon: ReadyWidgets().backIcon),
            Flexible(child: Text(provider.title, overflow: TextOverflow.ellipsis, style: Styles().titleWhite)),
          ],
        ),
      ) : const Center(),
    ),
  );
}

_bodyFood(context)
{
  foodInfoIcon(iconName, String info)
  {
    String capitilizedText(text) =>
    text![0].toString().toUpperCase()+text.toString().substring(1).toLowerCase();

    return Container
    (
      margin: const EdgeInsets.only(right: 8),
      width: 74,
      child: Column
      (children:
      [
        SizedBox(height: 48,child: Image.asset("images/$iconName.png")),
        const SizedBox(height: 12),
        Flexible(child: Text(capitilizedText(info), overflow: TextOverflow.visible, textAlign: TextAlign.center, style: Styles().foodPageText)),
      ]),
    );
  }

  columnPart(titleText, List<Widget> children) => Column
  (
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Text(titleText, style: Styles().subTitleBlack),
      const SizedBox(height: 8),
      Column(children: children)
    ],
  );

  nutritionCard(title, image, amount, unit) => Container
  (    
    width: MediaQuery.of(context).size.width*0.26,
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
        Text(title,style: Styles().categorieText),
        Image.asset(image),
        Text("$amount $unit",style: Styles().calorieText)
      ],
    ),
  );

  final prov = Provider.of<AppBarProviders>(context,listen: false);
  final provider = Provider.of<DataProviders>(context);

  return SingleChildScrollView
  (
    controller: prov.scrollController,
    child: Column
    (
      children:
      [
        Stack(children:
        [
          SizedBox(height: 300,width: double.maxFinite, child: provider.imageURL ==""? 
          Center(child: CircularProgressIndicator(color: Styles.greenColor)) : Image.network(provider.imageURL)),
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
                child: Text(provider.title,style: Styles().titleBlack)
              ),
              SizedBox
              (
                height: 98,
                child: ListView
                (
                  scrollDirection: Axis.horizontal,
                  children:
                  [
                    provider.isPopular == true? foodInfoIcon("popular","Very Popular") : const Center(),
                    provider.isCheap == true ? foodInfoIcon("losses", "Low Budget") : const Center(),                    
                    foodInfoIcon("time", "${provider.readyTime} Minutes"),
                    foodInfoIcon("healthcare", provider.healthScore),
                    foodInfoIcon("serving", "${provider.serving} Serving"),
                    foodInfoIcon("restaurant", provider.type),
                    foodInfoIcon("diet", provider.diet),
                    foodInfoIcon("nation", provider.cuisine),
                  ]
                ),
              ),
              Divider(color: Styles.greyColor),
              columnPart
              (
                "Summary",
                [
                  Text(provider.summary,style: Styles().foodPageText),
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
                    itemCount: provider.ingredientsList.length,
                    itemBuilder: (context, index) => RichText
                    (
                      text: TextSpan
                      (
                        text: "\u2022  ",style: Styles().foodPageBullet,
                        children:
                        [
                          TextSpan(text:"${provider.ingredientsList[index].amount} ${provider.ingredientsList[index].unit} ${provider.ingredientsList[index].name}",
                          style: Styles().foodPageText)
                        ]
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 6),
                  ),
                ]
              ),
              provider.instructionsList.isEmpty? const Center() : Divider(color: Styles.greyColor),
              provider.instructionsList.isEmpty? const Center() : columnPart
              (
                "Instructions",
                [
                  ListView.separated
                  (
                    padding: Measures.horizontal0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.instructionsList.length,
                    itemBuilder: (context, index) => RichText
                    (
                      text: TextSpan
                      (
                        text: "${provider.instructionsList[index].number}-)  ",style: Styles().foodPageBullet,
                        children: [TextSpan(text: provider.instructionsList[index].step,style: Styles().foodPageText)]
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
                    height: 172,
                    child: ListView.separated
                    (
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: provider.nutrientsList.length,
                      itemBuilder: (context, index) => nutritionCard
                      (
                        provider.nutrientsList[index].name,
                        nutrientsIcons[index]["image"],
                        provider.nutrientsList[index].amount.toInt(),
                        provider.nutrientsList[index].unit
                      ),
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