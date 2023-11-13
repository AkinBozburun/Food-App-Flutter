class Recipes {
  Recipes({
    required this.results,
    required this.totalResults,
  });
  late final List<Results> results;
  late final int totalResults;
  
  Recipes.fromJson(Map<String, dynamic> json){
    results = List.from(json['results']).map((e)=>Results.fromJson(e)).toList();
    totalResults = json['totalResults'];
  }
}

class Results {
  Results({
    required this.id,
    required this.title,
    required this.image,
  });
  late final int id;
  late final String title;
  late final String image;
  
  Results.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}