import 'dart:convert';

import 'package:shop_app/models/product_model.dart';

class FavoriteModel{
  late bool status;
  late FavoriteDataModel data;

  FavoriteModel.fromJson(json){
    status = json['status'];
    data = FavoriteDataModel.fromJson(json['data']);
  }
}
class FavoriteDataModel{
  late List<FavoriteProductModel> data = [];

  FavoriteDataModel.fromJson(json){
    json['data']. forEach((e){
      data.add(FavoriteProductModel.fromJson(e['product']));
    });
  }
}
class FavoriteProductModel{
  late int id;
  late dynamic price;
  late dynamic old_price;
  late dynamic discount;
  late String image;
  late String name;


  FavoriteProductModel.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];

  }

}
// class DataModel {
//    ProductModel? product ;
//
//   DataModel.fromJson(json){
//     ProductModel.fromJson(json);
//     // product.name = json['name'];
//     // product.id = json['id'];
//     // product.price = json['price'];
//     // product.old_price = json['old_price'];
//     // product.image = json['image'];
//     // product.discount = json['discount'];
//   }
// }

class FavoriteChangeModel{
  late bool status;
  late String message;

  FavoriteChangeModel.fromJson(json){
    status = json['status'];
    message = json['message'];
  }
}