import 'package:flutter/material.dart';

class Meisures
{
  static double height = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height;
  static double width = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width;

  static Radius radius16 = const Radius.circular(16);
  static BorderRadius border16 = BorderRadius.circular(16);
}