class Categories {
  String? category;
  String? id;
  String? image;
  String? price;
  String? productName;
  int? quantity;

  Categories(
      {this.category,
        this.id,
        this.image,
        this.price,
        this.productName,
        this.quantity});

  Categories.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    id = json['id'];
    image = json['image'];
    price = json['price'];
    productName = json['productName'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['id'] = this.id;
    data['image'] = this.image;
    data['price'] = this.price;
    data['productName'] = this.productName;
    data['quantity'] = this.quantity;
    return data;
  }
}