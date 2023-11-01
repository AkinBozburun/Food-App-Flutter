import 'package:flutter/material.dart';
import 'package:my_food_app/utils/local_datas.dart';
import 'package:my_food_app/utils/styles.dart';

class FilterBottomSheet extends StatelessWidget
{
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => IconButton
  (
    onPressed: ()=> _bottomSheet(context),
    icon: Icon(Icons.filter_alt, size: 32, color: Styles.whiteColor)
  );
}

_bottomSheet(context)
{
  showModalBottomSheet
  (
    context: context,
    builder: (context) => Container
    (
      margin: const EdgeInsets.all(16),
      child: Column
      (
        children:
        [
          Container(height: 4,width: 36,color: Styles.darkGreyColor),
          const SizedBox(height: 12),
          _gridview("Sort by",sortList),
          const SizedBox(height: 12),
          _gridview("Diet",dietList),
          const SizedBox(height: 12),
          _gridview("Cuisine",cuisinesList),
        ],
      ),
    ),
  );
}

_gridview(String title, List gridList)
{
  return Column
  (
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Text(title,style: Styles().bottomSheetTitleBlack),
      const SizedBox(height: 12),
      SizedBox
      (
        height: 42,
        child: ListView.separated
        (
          scrollDirection: Axis.horizontal,
          itemCount: gridList.length,
          itemBuilder: (context, index) => Container
          (
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration
            (
              border: Border.all(color: Styles.greenColor), color: Styles.whiteColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(child: Text(gridList[index]["text"],style: Styles().bottomSheetSpeciesText)),
          ),
          separatorBuilder: (context, index) => const SizedBox(width: 6),
        ),
      ),      
    ]
  );
}