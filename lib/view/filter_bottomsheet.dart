import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_food_app/utils/local_datas.dart';
import 'package:my_food_app/utils/measures.dart';
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
  double deviceHeight = MediaQuery.of(context).size.height;
  double deviceWidth = MediaQuery.of(context).size.width;

  showModalBottomSheet
  (
    //isScrollControlled: true,
    context: context,
    builder: (context) => Container
    (
      height: deviceHeight,
      margin: const EdgeInsets.all(16),
      child: Column
      (
        //runSpacing: 16,
        //alignment: WrapAlignment.center,
        children:
        [
          Container(height: 4,width: 36,color: Styles.darkGreyColor),
          
          _gridview("Sort by", sortList, deviceWidth),          
          _gridview("Diet", dietList, deviceWidth),          
          _gridview("Cuisine", cuisinesList, deviceWidth),          
          _buttonsRow(deviceWidth),
        ],
      ),
    ),
  );
}

_gridview(String title, List gridList, double width)
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
        height: 72,
        width: width,
        child: MasonryGridView.builder
        (
          itemCount: gridList.length,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate:  const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          itemBuilder: (context, index) => Container
          (
            padding: Measures.horizontal16,
            decoration: BoxDecoration
            (
              border: Border.all(color: Styles.greenColor), color: Styles.whiteColor,
              borderRadius: Measures.border24,
            ),
            child: Center(child: Text(gridList[index]["text"],style: Styles().bottomSheetSpeciesText)),
          ),
        ),
      ),
    ]
  );
}

_buttonsRow(width)
{
  return Row
  (
    children:
    [
      InkWell
      (
        onTap: (){},
        child: Ink
        (
          height: 36,
          color: Styles.greyColor,
          child: const Center(child: Text("Clear All"))
        ),
      ),
    ],
  );
}