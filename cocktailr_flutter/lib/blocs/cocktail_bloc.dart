import 'package:cocktailr_flutter/models/cocktail.dart';
import 'package:cocktailr_flutter/repositories/cocktail_repository.dart';
import 'package:rxdart/rxdart.dart';

class CocktailBloc {
  CocktailBloc._privateConstructor();
  static final CocktailBloc _instance = CocktailBloc._privateConstructor();
  factory CocktailBloc() {
    return _instance;
  }

  final _repository = CocktailRepository();

  final _ingredientsFetcher = BehaviorSubject<List<String>>();
  final _cocktailsFetcher = BehaviorSubject<List<Cocktail>>();
  final _cocktailFetcher = PublishSubject<Cocktail>();

  Observable<List<String>> get ingredients => _ingredientsFetcher.stream;
  Observable<List<Cocktail>> get cocktails => _cocktailsFetcher.stream;
  Observable<Cocktail> get cocktail => _cocktailFetcher.stream;

  fetchAllIngredients() async {
    List<String> ingredients = await _repository.getAllIngredients();
    _ingredientsFetcher.sink.add(ingredients);
  }

  fetchCocktailsByIngredient(String ingredient) async {
    List<Cocktail> cocktails =
        await _repository.getCocktailsByIngredient(ingredient);
    _cocktailsFetcher.sink.add(cocktails);
  }

  fetchCocktailById(Cocktail cocktail) async {
    Cocktail detailedCocktail = await _repository.getCocktailDetails(cocktail);
    _cocktailFetcher.sink.add(detailedCocktail);
  }

  dispose() {
    _ingredientsFetcher.close();
    _cocktailsFetcher.close();
    _cocktailFetcher.close();
  }
}
