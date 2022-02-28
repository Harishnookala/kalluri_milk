class Products {
  ProductDetails? productDetails;

  Products({this.productDetails});

  Products.fromJson(Map<String, dynamic> json) {
    productDetails = json['Product_details'] != null
        ? new ProductDetails.fromJson(json['Product_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productDetails != null) {
      data['Product_details'] = this.productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  List<Categories>? categories;

  ProductDetails({this.categories});

  ProductDetails.fromJson(Map<String, dynamic> json) {
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
  int? price;
  String? productName;
  int? quantity;
  String? image;

  Categories({this.price, this.productName, this.quantity, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    price = json['Price'];
    productName = json['ProductName'];
    quantity = json['Quantity'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Price'] = this.price;
    data['ProductName'] = this.productName;
    data['Quantity'] = this.quantity;
    data['Image'] = this.image;
    return data;
  }
}
