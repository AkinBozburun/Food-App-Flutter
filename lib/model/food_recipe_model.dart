class Food
{
  Food({required this.healthScore, required this.id, required this.title, required this.readyInMinutes, required this.servings, required this.image, required this.nutrition, required this.summary, required this.analyzedInstructions});

  late final int healthScore;
  late final int id;
  late final String title;
  late final int readyInMinutes;
  late final int servings;
  late final String image;
  late final Nutrition nutrition;
  late final String summary;
  late final List<AnalyzedInstructions> analyzedInstructions;
  
  Food.fromJson(Map<String, dynamic> json)
  {
    healthScore = json['healthScore'];
    id = json['id'];
    title = json['title'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    image = json['image'];
    nutrition = Nutrition.fromJson(json['nutrition']);
    summary = json['summary'];
    analyzedInstructions = List.from(json['analyzedInstructions']).map((e)=>AnalyzedInstructions.fromJson(e)).toList();
  }
}

class Nutrition
{
  Nutrition({required this.nutrients, required this.ingredients});
  late final List<Nutrients> nutrients;

  late final List<Ingredients> ingredients;
  
  Nutrition.fromJson(Map<String, dynamic> json)
  {
    nutrients = List.from(json['nutrients']).map((e)=>Nutrients.fromJson(e)).toList();
    ingredients = List.from(json['ingredients']).map((e)=>Ingredients.fromJson(e)).toList();
  }
}

class Nutrients
{
  Nutrients({required this.name, required this.amount, required this.unit, required this.percentOfDailyNeeds});

  late final String name;
  late final double amount;
  late final String unit;
  late final double percentOfDailyNeeds;
  
  Nutrients.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
    percentOfDailyNeeds = json['percentOfDailyNeeds'];
  }
}

class Ingredients
{
  Ingredients({required this.name, required this.amount, required this.unit});

  late final String name;
  late final double amount;
  late final String unit;
  
  Ingredients.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
  }
}

class AnalyzedInstructions
{
  AnalyzedInstructions({required this.steps});

  late final List<Steps> steps;
  
  AnalyzedInstructions.fromJson(Map<String, dynamic> json)
  {
    steps = List.from(json['steps']).map((e)=>Steps.fromJson(e)).toList();
  }
}

class Steps
{
  Steps({required this.number, required this.step});

  late final int number;
  late final String step;
  
  Steps.fromJson(Map<String, dynamic> json)
  {
    number = json['number'];
    step = json['step'];
  }
}