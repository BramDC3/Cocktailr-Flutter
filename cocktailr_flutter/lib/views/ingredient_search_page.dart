import 'package:cocktailr_flutter/blocs/cocktail_bloc.dart';
import 'package:flutter/material.dart';

class IngredientSearchPage extends StatefulWidget {
  @override
  _IngredientSearchPageState createState() => _IngredientSearchPageState();
}

class _IngredientSearchPageState extends State<IngredientSearchPage> {
  final CocktailBloc bloc = CocktailBloc();
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        filter = controller.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search by ingredient"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Search by ingredient...',
                ),
              ),
            ),
            StreamBuilder(
              stream: bloc.ingredients,
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  return _buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<List<String>> snapshot) {
    return Expanded(
      child: ListView.builder(
        itemCount: snapshot.data.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int i) {
          return filter == "" || filter == null
              ? _makeListTile(snapshot.data[i])
              : snapshot.data[i].toLowerCase().contains(filter)
                  ? _makeListTile(snapshot.data[i])
                  : Container();
        },
      ),
    );
  }

  Widget _makeListTile(String ingredient) {
    return ListTile(
      leading: Icon(Icons.local_bar, color: Colors.black87),
      title: Text(ingredient),
      onTap: () => _backToList(ingredient),
    );
  }

  void _backToList(String ingredient) {
    bloc.fetchCocktailsByIngredient(ingredient);
    Navigator.pop(context);
  }
}
