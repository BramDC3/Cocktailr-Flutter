class Cocktail {
  String id, name, category, instructions, image;
  List<String> ingredients, measurements;

  Cocktail({
    this.id,
    this.name,
    this.image,
  });

  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['idDrink'],
      name: json['strDrink'],
      image: json['strDrinkThumb'],
    );
  }
  
}
