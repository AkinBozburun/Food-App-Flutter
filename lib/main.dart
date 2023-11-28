import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/view/main_page.dart';
import 'package:my_food_app/view/no_internet_page.dart';
import 'package:provider/provider.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //await Hive.initFlutter();
  //Hive.registerAdapter(FavCitiesAdapter());
  //Hive.openBox<FavCities>("favCities");
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
        home: const MainPage()
      ),
    );
  }
}

class NetCheck extends StatefulWidget
{
  final page;
  
  const NetCheck({super.key, required this.page}); 

  @override
  State<NetCheck> createState() => _NetCheckState();
}

class _NetCheckState extends State<NetCheck>
{
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
      future: Connectivity().checkConnectivity(),
      builder: (context, snapshot)
      {
        if(snapshot.data == ConnectivityResult.none)
        {
          return const NoInternetPage();
        }
        else
        {
          return widget.page ?? const MainPage();
        }
      }
    );
  }
}