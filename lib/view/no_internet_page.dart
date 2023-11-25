import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:my_food_app/main.dart';
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
      Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const NetCheck()),
      (route) => false);
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
            //SizedBox
            //(
            //  height: 140,
            //  width: 140,
            //  child: Image.asset("images/no-internet.png")
            //),
            //const SizedBox(height: 30),
            Text("Check your Internet Connection",style: Styles().titleWhite),
            const SizedBox(height: 30),
            IconButton(onPressed: () => _netCheck(context), icon: Icon(Icons.refresh,size: 48, color: Styles.whiteColor))
          ],
        ),
      ),
    );
  }
}