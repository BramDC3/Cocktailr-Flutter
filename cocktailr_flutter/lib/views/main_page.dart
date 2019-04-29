import 'package:cocktailr_flutter/blocs/cocktail_bloc.dart';
import 'package:cocktailr_flutter/views/add_suggestion_page.dart';
import 'package:cocktailr_flutter/views/cocktail_list_page.dart';
import 'package:cocktailr_flutter/views/ingredient_search_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;
  static CocktailListPage cocktailListPage = CocktailListPage();
  static AddSuggestionPage addSuggestionPage = AddSuggestionPage();
  final List<Widget> _pages = [cocktailListPage, addSuggestionPage];

  final CocktailBloc bloc = CocktailBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchAllIngredients();
    bloc.fetchCocktailsByIngredient("Tequila");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            _selectedPage == 0 ? Text('Cocktailr') : Text('Make a suggestion'),
        actions: <Widget>[
          _selectedPage == 0
              ? IconButton(
                  onPressed: _navigateToSearch,
                  icon: Icon(Icons.search),
                )
              : Container(),
        ],
      ),
      body: _pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_bar),
            title: Text("Cocktails"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            title: Text("Suggestion"),
          ),
        ],
      ),
    );
  }

  void _navigateToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IngredientSearchPage(),
      ),
    );
  }
}
