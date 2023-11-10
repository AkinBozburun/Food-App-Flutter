import 'package:flutter/material.dart';
import 'package:my_food_app/utils/providers.dart';
import 'package:my_food_app/view/main_page.dart';
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
      ],
      child: MaterialApp
      (
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const MainPage(),
      ),
    );
  }
}