class Book {
  final int id;
  final String image;
  final String name;
  final int quantity;
  final int price;

  Book({this.id, this.image, this.name, this.quantity, this.price});

  factory Book.formJson(Map<String, dynamic> json) {
    return Book(
      id: json['Id'],
      image: json['Image'],
      name: json['Name'],
      quantity: json['Quantity'],
      price: json['Price'],
    );
  }
}
