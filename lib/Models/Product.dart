class Products {
  // int? id;
  String? title;
  String? description;
  int? price;
  // double? discountPercentage;
  // double? rating;
  // String? brand;
  String? thumbnail;
  List<String>? images;

  Products(
      {
      // this.id,
      this.title,
      this.description,
      this.price,
      // this.discountPercentage,
      // this.rating,
      // this.brand,
      this.thumbnail,
      this.images});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      // id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      // discountPercentage: json['discountPercentage'],
      // rating: json['rating'],
      // brand: json['brand'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
    );
  }
}
