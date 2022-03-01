class RegisterModel {
  bool status;
  String message;
  Data data;

  RegisterModel({this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
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
  User user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String image;
  String name;
  String email;
  String mobile;
  String countryCode;
  Currency currency;
  String language;
  bool isNotify;
  bool isGuest;
  String activeCode;
  bool isActive;
  int authType;
  Null address;

  User(
      {this.id,
        this.image,
        this.name,
        this.email,
        this.mobile,
        this.countryCode,
        this.currency,
        this.language,
        this.isNotify,
        this.isGuest,
        this.activeCode,
        this.isActive,
        this.authType,
        this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    countryCode = json['country_code'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    language = json['language'];
    isNotify = json['is_notify'];
    isGuest = json['is_guest'];
    activeCode = json['active_code'];
    isActive = json['is_active'];
    authType = json['auth_type'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['country_code'] = this.countryCode;
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    data['language'] = this.language;
    data['is_notify'] = this.isNotify;
    data['is_guest'] = this.isGuest;
    data['active_code'] = this.activeCode;
    data['is_active'] = this.isActive;
    data['auth_type'] = this.authType;
    data['address'] = this.address;
    return data;
  }
}

class Currency {
  int id;
  String name;
  String symbol;
  double exchangeRate;
  String icon;

  Currency({this.id, this.name, this.symbol, this.exchangeRate, this.icon});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    exchangeRate = json['exchange_rate'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['exchange_rate'] = this.exchangeRate;
    data['icon'] = this.icon;
    return data;
  }
}