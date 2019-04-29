import 'package:cocktailr_flutter/blocs/cocktail_bloc.dart';
import 'package:cocktailr_flutter/models/cocktail.dart';
import 'package:flutter/material.dart';

class CocktailDetailPage extends StatefulWidget {
  final String title;
  CocktailDetailPage({@required this.title});

  @override
  _CocktailDetailPageState createState() => _CocktailDetailPageState();
}

class _CocktailDetailPageState extends State<CocktailDetailPage> {
  final CocktailBloc bloc = CocktailBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: bloc.cocktail,
        builder: (context, AsyncSnapshot<Cocktail> snapshot) {
          if (snapshot.hasData) {
            return _buildBody(snapshot);
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildBody(AsyncSnapshot<Cocktail> snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network(snapshot.data.image),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  snapshot.data.name,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Category: ${snapshot.data.category}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 12),
                Text(snapshot.data.instructions),
                SizedBox(height: 12),
                Table(
                  border: TableBorder.all(),
                  children: _createTable(snapshot.data),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TableRow> _createTable(Cocktail cocktail) {
    List<TableRow> tableList = [];
    tableList.add(
      TableRow(
        children: [
          Padding(
            child: Text(
              "INGREDIENT",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(4),
          ),
          Padding(
            child: Text(
              "MEASUREMENT",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            padding: EdgeInsets.all(4),
          )
        ],
      ),
    );
    for (int i = 0; i < cocktail.ingredients.length; i++) {
      tableList.add(
        TableRow(
          children: [
            Padding(
              child: Text(cocktail.ingredients[i]),
              padding: EdgeInsets.all(4),
            ),
            Padding(
              child: Text(i < cocktail.measurements.length
                  ? cocktail.measurements[i]
                  : ''),
              padding: EdgeInsets.all(4),
            )
          ],
        ),
      );
    }
    return tableList;
  }
}
