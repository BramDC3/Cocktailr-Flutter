import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cocktail.dart';

class CocktailApi {
  String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/36578';

  Future<Cocktail> getCocktailById(Cocktail cocktail) async {
    final res = await http.get('$baseUrl/lookup.php?i=${cocktail.id}');
    Map<String, dynamic> jsonCocktail = json.decode(res.body)['drinks'][0];
    cocktail.category = jsonCocktail['strCategory'];
    cocktail.instructions = jsonCocktail['strInstructions'];
    cocktail.ingredients = toList(jsonCocktail, 'strIngredient');
    cocktail.measurements = toList(jsonCocktail, 'strMeasure');
    return cocktail;
  }

  Future<List<Cocktail>> getCocktailsByIngredient(String ingredient) async {
    final res = await http.get('$baseUrl/filter.php?i=$ingredient');
    final list = json.decode(res.body)['drinks'];
    List<Cocktail> cocktails = [];
    for (int i = 0; i < list.length; i++) {
      cocktails.add(Cocktail.fromJson(list[i]));
    }
    return cocktails;
  }

  Future<List<String>> getAllIngredients() async {
    final res = await http.get('$baseUrl/list.php?i=list');
    final list = json.decode(res.body)['drinks'];
    List<String> ingredients = [];
    for (int i = 0; i < list.length; i++) {
      ingredients.add(list[i]['strIngredient1']);
    }
    return ingredients;
  }

  List<String> toList(Map<String, dynamic> json, String tag) {
    List<String> list = List.generate(15, (int i) => json['$tag${i + 1}']);
    list.removeWhere((i) => i == '' || i == ' ' || i == '\n' || i == null);
    return list;
  }
}
