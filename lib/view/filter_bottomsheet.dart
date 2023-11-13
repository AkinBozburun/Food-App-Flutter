import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_food_app/utils/local_datas.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/utils/styles.dart';
import 'package:provider/provider.dart';

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
  double deviceWidth = MediaQuery.of(context).size.width;

  showModalBottomSheet
  (
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (context) => Container
    (
      margin: Measures.all16,
      child: Wrap
      (
        alignment: WrapAlignment.center,
        runSpacing: 12,
        children:
        [
          Container(height: 4,width: 36,color: Styles.darkGreyColor),
          _gridview(context,"Sort by", sortList, deviceWidth),
          _gridview(context,"Diet", dietList, deviceWidth),
          _gridview(context,"Cuisine", cuisinesList, deviceWidth),
          Divider(color: Styles.greyColor),
          _buttonsRow(context, deviceWidth),
        ],
      ),
    ),
  );
}

_gridview(context,String title, List gridList, double width)
{
  final provider = Provider.of<FilterProviders>(context);

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
          gridDelegate:  const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          itemBuilder: (context, index) => GestureDetector
          (
            onTap: ()
            {
              provider.buttonSwitch(title ,gridList[index]["text"], index);
            },
            child: AnimatedContainer
            (
              duration: const Duration(milliseconds: 100),
              padding: Measures.horizontal16,
              decoration: BoxDecoration
              (
                color: provider.listItem(title, index) == false? Styles.whiteColor : Styles.greenColor,
                border: Border.all(color: Styles.greenColor),
                borderRadius: Measures.border24,
              ),
              child: Center(child: Text
              (
                gridList[index]["text"],
                style: provider.listItem(title, index) == false?
                Styles().bottomSheetSpeciesTextBlack : Styles().bottomSheetSpeciesTextWhite
              )),
            ),
          ),
        ),
      ),
    ]
  );
}

_buttonsRow(context, width)
{
  button(Text txt, Color clr, tap) => InkWell
  (
    borderRadius: Measures.border12,
    onTap: tap,
    child: Ink
    (
      decoration: BoxDecoration
      (
        color: clr,
        borderRadius: Measures.border12
      ),
      width: width*0.4,
      height: 42,
      child: Center(child: txt)
    ),
  );

  final dataProv = Provider.of<DataProviders>(context);
  final filterProv = Provider.of<FilterProviders>(context);

  return Row
  (
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children:
    [
      button(Text("Clear All",style: Styles().bottomSheetTitleBlack),
      Styles.greyColor, ()=> filterProv.clearAllButtons()),
      button(Text("Show Results",style: Styles().bottomSheetTitleWhite),
      Styles.greenColor ,()
      {
        dataProv.gatherSelectedItems();
        Navigator.pop(context);
      }),
    ],
  );
}