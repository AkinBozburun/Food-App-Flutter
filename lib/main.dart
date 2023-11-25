import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/view/main_page.dart';
import 'package:my_food_app/view/no_internet_page.dart';
import 'package:provider/provider.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MultiProvider
    (
      providers:
      [
        ChangeNotifierProvider(create: (context) => AppBarProviders()),
        ChangeNotifierProvider(create: (context) => FilterProviders()),
        ChangeNotifierProvider(create: (context) => DataProviders()),
      ],
      child: MaterialApp
      (
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const NetCheck(),
      ),
    );
  }
}

class NetCheck extends StatefulWidget
{
  const NetCheck({super.key});

  @override
  State<NetCheck> createState() => _NetCheckState();
}

class _NetCheckState extends State<NetCheck>
{
  Future _netCheck() async
  {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult;
  }

@override
  void initState()
  {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder
    (
      future: _netCheck(),
      builder: (context, snapshot)
      {
        if(snapshot.data == ConnectivityResult.none)
        {
          return const NoInternetPage();
        }
        else
        {
          return const MainPage();
        }
      }
    );
  }
}