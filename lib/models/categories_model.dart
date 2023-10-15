class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(json){
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);

  }
}

class CategoriesDataModel{
  late int current_page;
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(json){
    current_page = json['current_page'];
    json['data'].forEach((e){
        data.add(DataModel.fromJson(e));
    });

  }
}
class DataModel{
  late int id;
  late String name;
  late String image;

  DataModel.fromJson(json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}