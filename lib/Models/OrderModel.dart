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
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['zip'] = this.zip;
    data['city'] = this.city;
    data['country'] = this.country;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catId'] = this.catId;
    data['title'] = this.title;
    data['unit'] = this.unit;
    data['stockAvailable'] = this.stockAvailable;
    data['image'] = this.image;
    data['color'] = this.color;
    data['price'] = this.price;
    data['qty'] = this.qty;
    return data;
  }
}