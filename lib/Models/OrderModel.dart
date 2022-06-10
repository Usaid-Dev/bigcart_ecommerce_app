class OrderModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? zip;
  String? city;
  String? country;
  int? orderId;
  List<Items>? items;

  OrderModel(
      {this.name,
        this.email,
        this.phoneNumber,
        this.address,
        this.zip,
        this.city,
        this.country,
        this.items});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    zip = json['zip'];
    city = json['city'];
    country = json['country'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['zip'] = zip;
    data['city'] = city;
    data['country'] = country;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? catId;
  String? title;
  String? unit;
  int? stockAvailable;
  String? image;
  String? color;
  double? price;
  int? qty;

  Items(
      {this.id,
        this.catId,
        this.title,
        this.unit,
        this.stockAvailable,
        this.image,
        this.color,
        this.price,
        this.qty});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['catId'];
    title = json['title'];
    unit = json['unit'];
    stockAvailable = json['stockAvailable'];
    image = json['image'];
    color = json['color'];
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['catId'] = catId;
    data['title'] = title;
    data['unit'] = unit;
    data['stockAvailable'] = stockAvailable;
    data['image'] = image;
    data['color'] = color;
    data['price'] = price;
    data['qty'] = qty;
    return data;
  }
}