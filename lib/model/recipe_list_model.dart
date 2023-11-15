class Recipes
{
  Recipes({required this.results, required this.totalResults});
  late final List<Results> results;
  late final int totalResults;
  
  Recipes.fromJson(Map<String, dynamic> json)
  {
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
    totalResults = json['totalResults'];
  }
}

class Results
{
  Results({required this.id, required this.title, required this.image, required this.nutrition});

  late final int id;
  late final String title;
  late final String image;
  late final Nutrition? nutrition;
  
  Results.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    nutrition = json['nutrition'] == null ? null : Nutrition.fromJson(json['nutrition']);
  }
}

class Nutrition
{
  Nutrition({required this.nutrients});

  late final List<Nutrients> nutrients;
  
  Nutrition.fromJson(Map<String, dynamic> json)
  {
    nutrients = List.from(json['nutrients']).map((e)=>Nutrients.fromJson(e)).toList();
  }
}

class Nutrients
{
  Nutrients({required this.name, required this.amount});
  
  late final String name;
  late final double amount;
  
  Nutrients.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    amount = json['amount'];
  }
}