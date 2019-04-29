import 'package:cocktailr_flutter/models/cocktail.dart';
import 'package:cocktailr_flutter/network/cocktail_api.dart';

class CocktailRepository {
  final cocktailApi = CocktailApi();

  Future<Cocktail> getCocktailDetails(Cocktail cocktail) => cocktailApi.getCocktailById(cocktail);
  Future<List<String>> getAllIngredients() => cocktailApi.getAllIngredients();
  Future<List<Cocktail>> getCocktailsByIngredient(String ingredient) => cocktailApi.getCocktailsByIngredient(ingredient);
}
