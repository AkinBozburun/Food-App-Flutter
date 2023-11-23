class Recipes
{
  Recipes({required this.results, required this.totalResults});
  
  late final List<Results> results;
  late final int offset;
  late final int totalResults;
  
  Recipes.fromJson(Map<String, dynamic> json)
  {
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
    offset = json['offset'];
    totalResults = json['totalResults'];
  }
}

class Results
{
  Results({required this.id, required this.title, required this.image, required this.nutrition});

  late final int id;
  late final String title;
  late final String image;
  late final NutritionInList? nutrition;
  
  Results.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    nutrition = json['nutrition'] == null ? null : NutritionInList.fromJson(json['nutrition']);
  }
}

class NutritionInList
{
  NutritionInList({required this.nutrients});

  late final List<NutrientsInList> nutrients;
  
  NutritionInList.fromJson(Map<String, dynamic> json)
  {
    nutrients = List.from(json['nutrients']).map((e)=>NutrientsInList.fromJson(e)).toList();
  }
}

class NutrientsInList
{
  NutrientsInList({required this.name, required this.amount});
  
  late final String name;
  late final double amount;
  late final String unit;
  
  NutrientsInList.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
  }
}