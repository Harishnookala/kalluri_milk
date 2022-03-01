class Products {
  List<Categories>? categories;

  Products({this.categories});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['Categories'] != null) {
      categories = <Categories>[];
      json['Categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['Categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? category;
  int? price;
  String? productName;
  int? quantity;
  String? image;

  Categories(
      {this.category, this.price, this.productName, this.quantity, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    price = json['Price'];
    productName = json['ProductName'];
    quantity = json['Quantity'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['Price'] = this.price;
    data['ProductName'] = this.productName;
    data['Quantity'] = this.quantity;
    data['Image'] = this.image;
    return data;
  }
}