import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddSuggestionPage extends StatefulWidget {
  @override
  _AddSuggestionPageState createState() => _AddSuggestionPageState();
}

class _AddSuggestionPageState extends State<AddSuggestionPage> {
  String _dropdownValue = "Cocktail";
  Image _image = Image.asset(
    "assets/cocktail_example.jpg",
    fit: BoxFit.fitWidth,
  );
  bool _madePicture = false;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1 / 1,
            child: _image,
          ),
          SizedBox(height: 20),
          Text("Name", style: TextStyle(color: Colors.black, fontSize: 15)),
          SizedBox(height: 4),
          TextField(
            keyboardType: TextInputType.text,
            controller: _nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          SizedBox(height: 16),
          Text("Category", style: TextStyle(color: Colors.black, fontSize: 15)),
          SizedBox(height: 4),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              contentPadding: EdgeInsets.all(10),
            ),
            value: _dropdownValue,
            onChanged: (String newValue) {
              setState(() {
                _dropdownValue = newValue;
              });
            },
            items: <String>[
              "Cocktail",
              "Ordinary Drink",
              "Beer",
              "Punch / Party Drink",
              "Other / Unknown",
              "Shot"
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 16),
          Text("Description",
              style: TextStyle(color: Colors.black, fontSize: 15)),
          SizedBox(height: 4),
          TextField(
            maxLines: 3,
            keyboardType: TextInputType.text,
            controller: _descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              contentPadding: EdgeInsets.all(16),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  color: Colors.redAccent.shade100,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text("MAKE SUGGESTION",
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  onPressed: () => _validateForm(context),
                ),
              ),
              Container(
                color: Colors.redAccent.shade100,
                margin: EdgeInsets.only(left: 24),
                child: IconButton(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  icon: Icon(Icons.camera_alt),
                  onPressed: _getImage,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _validateForm(BuildContext context) {
    if (_nameController.text != null &&
        _nameController.text != "" &&
        _descriptionController.text != null &&
        _descriptionController.text != "" &&
        _madePicture) {
      final scaffold = Scaffold.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text('Thank you for your suggestion!'),
        ),
      );
    }
  }

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _madePicture = true;
      _image = Image.file(
        image,
        fit: BoxFit.fitWidth,
      );
    });
  }
}
