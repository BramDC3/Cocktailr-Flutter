import 'package:cocktailr_flutter/blocs/cocktail_bloc.dart';
import 'package:cocktailr_flutter/models/cocktail.dart';
import 'package:cocktailr_flutter/views/cocktail_detail_page.dart';
import 'package:flutter/material.dart';

class CocktailListPage extends StatefulWidget {
  @override
  _CocktailListPageState createState() => _CocktailListPageState();
}

class _CocktailListPageState extends State<CocktailListPage> {
  final CocktailBloc bloc = CocktailBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.cocktails,
      builder: (context, AsyncSnapshot<List<Cocktail>> snapshot) {
        if (snapshot.hasData) {
          return _buildList(snapshot);
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildList(AsyncSnapshot<List<Cocktail>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int i) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () => _navigateToDetail(snapshot.data[i]),
              child: Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Hero(
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child:
                              Image.network(snapshot.data[i].image, width: 90),
                        ),
                        tag: snapshot.data[i].id,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data[i].name,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "ID: ${snapshot.data[i].id}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToDetail(Cocktail cocktail) {
    bloc.fetchCocktailById(cocktail);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CocktailDetailPage(title: cocktail.name),
      ),
    );
  }
}
