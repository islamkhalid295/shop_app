
class LoginModel {
  late bool status;
  late dynamic message;
  UserData? data;

  LoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message =json['message'];
    data =json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;
  UserData.fromJson(json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}