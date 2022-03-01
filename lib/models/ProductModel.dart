class ProductModel {
  bool status;
  String message;
  Data data;

  ProductModel({this.status, this.message, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
  String title;
  String subTitle;
  String description;
  int price;
  bool isFav;
  bool isRate;
  Null rateAvg;
  List<Null> rates;
  int remainingQty;
  bool hasOption;
  String optionName;
  int optionPrice;
  List<Images> images;
  int isShipping;

  Data(
      {this.id,
        this.title,
        this.subTitle,
        this.description,
        this.price,
        this.isFav,
        this.isRate,
        this.rateAvg,
        this.rates,
        this.remainingQty,
        this.hasOption,
        this.optionName,
        this.optionPrice,
        this.images,
        this.isShipping});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    description = json['description'];
    price = json['price'];
    isFav = json['isFav'];
    isRate = json['is_rate'];
    rateAvg = json['rate_avg'];
    // if (json['rates'] != null) {
    //   rates = <Null>[];
    //   json['rates'].forEach((v) {
    //     rates.add(new Null.fromJson(v));
    //   });
    // }
    remainingQty = json['remaining_qty'];
    hasOption = json['has_option'];
    optionName = json['option_name'];
    optionPrice = json['option_price'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    isShipping = json['is_shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['description'] = this.description;
    data['price'] = this.price;
    data['isFav'] = this.isFav;
    data['is_rate'] = this.isRate;
    data['rate_avg'] = this.rateAvg;
    // if (this.rates != null) {
    //   data['rates'] = this.rates.map((v) => v.toJson()).toList();
    // }
    data['remaining_qty'] = this.remainingQty;
    data['has_option'] = this.hasOption;
    data['option_name'] = this.optionName;
    data['option_price'] = this.optionPrice;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['is_shipping'] = this.isShipping;
    return data;
  }
}

class Images {
  int id;
  String image;
  bool isDefault;

  Images({this.id, this.image, this.isDefault});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['is_default'] = this.isDefault;
    return data;
  }
}