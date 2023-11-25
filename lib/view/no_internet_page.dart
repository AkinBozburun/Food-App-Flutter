import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_food_app/main.dart';
import 'package:my_food_app/utils/measures.dart';
import 'package:my_food_app/utils/styles.dart';

class NoInternetPage extends StatefulWidget
{
  const NoInternetPage({super.key});

  @override
  State<NoInternetPage> createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage>
{

  _netCheck(context) async
  {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult != ConnectivityResult.none)
    {
      Navigator.pushAndRemoveUntil
      (
        context,MaterialPageRoute(builder: (context) => const NetCheck()),
        (route) => false
      );
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: Styles.greenColor,
      body: Center
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            SizedBox(height: 164, width: 164,child: Image.asset("images/alert.png")),
            const SizedBox(height: 36),
            Text("No Internet Connection!",style: Styles().titleWhite),
            Text("Please check your Wi-Fi or mobile data",style: Styles().bottomSheetTitleWhite),
            const SizedBox(height: 32),
            InkWell(onTap: () => _netCheck(context),
            borderRadius: Measures.border24,
            child: Ink
            (
              height: 36,
              width: 128,
              decoration: BoxDecoration
              (
                color: Styles.whiteColor,
                borderRadius: Measures.border24
              ),
              child: Center(child: Text("Try Again",style: Styles().bottomSheetTitleBlack)),
            )),
          ],
        ),
      ),
    );
  }
}