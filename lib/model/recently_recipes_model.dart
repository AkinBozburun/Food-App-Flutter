import 'package:hive/hive.dart';

part 'recently_recipes_model.g.dart';

@HiveType(typeId: 0)
class RecentlyRecipes extends HiveObject
{
  @HiveField(0)
  late int recentlyID;

  @HiveField(1)
  late String recentlyPhoto;

  @HiveField(2)
  late String recentlyName;

  @HiveField(3)
  late String recentlyReadyTime;

  @HiveField(4)
  late String recentlyScore;
}