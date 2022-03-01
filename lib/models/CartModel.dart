class CartModel {
  bool status;
  String message;
  Data data;

  CartModel({this.status, this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  int total;
  List<CartProducts> cartProducts;

  Data({this.id, this.total, this.cartProducts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    if (json['cart_products'] != null) {
      cartProducts = <CartProducts>[];
      json['cart_products'].forEach((v) {
        cartProducts.add(new CartProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total'] = this.total;
    if (this.cartProducts != null) {
      data['cart_products'] =
          this.cartProducts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProducts {
  int id;
  String productName;
  String productImage;
  int qty;
  int price;
  int total;
  bool isShipping;
  bool hasOption;
  String optionName;
  int optionPrice;

  CartProducts(
      {this.id,
        this.productName,
        this.productImage,
        this.qty,
        this.price,
        this.total,
        this.isShipping,
        this.hasOption,
        this.optionName,
        this.optionPrice});

  CartProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    qty = json['qty'];
    price = json['price'];
    total = json['total'];
    isShipping = json['is_shipping'];
    hasOption = json['has_option'];
    optionName = json['option_name'];
    optionPrice = json['option_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['total'] = this.total;
    data['is_shipping'] = this.isShipping;
    data['has_option'] = this.hasOption;
    data['option_name'] = this.optionName;
    data['option_price'] = this.optionPrice;
    return data;
  }
}