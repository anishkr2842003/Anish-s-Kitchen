class RecipeModel
{
  late String applabel;
  late String appimgUrl;
  late double appcalories;
  late String appurl;

  RecipeModel({required this.applabel, required this.appimgUrl, required this.appcalories, required this.appurl});
  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
      applabel: recipe["label"],
      appimgUrl: recipe["image"],
      appurl: recipe["url"],
      appcalories: recipe["calories"],
    );
  }



}