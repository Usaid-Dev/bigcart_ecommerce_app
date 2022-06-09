import 'package:bigcart_ecommerce_app/Models/Api_DataModel.dart';
class CategoryModel extends ApiDataModel {
  int? id;
  String? title;
  String? icon;
  String? color;

  CategoryModel({this.id, this.title, this.icon, this.color});

  @override
  Map<String, dynamic> toJson() =>{
    "id": id,
    "title": title,
    "icon": icon,
    "color": color,
  };

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    title: json["title"],
    icon: json["icon"],
    color: json["color"],
  );
  /* CategoryModel.fromJson(List<dynamic> jsonlist){
     jsonlist.forEach((element) {
       CategoryModel(catList: CategoryModel(
         id: element["id"],
         title: element["title"],
         icon: element["icon"],
         color: element["color"],
       ) as List<CategoryModel>);
       print(element["color"]);
     });
  }*/



}