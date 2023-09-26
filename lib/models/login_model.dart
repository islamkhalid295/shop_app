class LoginModel {
  late bool status;
  late String message;
  UserData? data;
}

class UserData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;
}