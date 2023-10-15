import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/home_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class LoginCubit extends Cubit<AppStates> {
  LoginCubit(super.initialState);
  String? token;
  String test  = 'ssd';
  static LoginCubit get(context) => BlocProvider.of(context);
  void login (String email, String password,BuildContext context ){
    print(email+password);
    emit(LodingState());
    DioHelper.postData('login', {'email':email, 'password':password}).then((value) {
      LoginModel loginModel = LoginModel.fromJson(value.data);
      token = loginModel.data?.token;
      print('token : ${token}');
      CacheHelper.saveData('token', token).then((value) {
        print(CacheHelper.getData('token'));
        toast(loginModel.message, loginModel.status? Colors.green : Colors.red);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        emit(LoginSucssesState());
      });
    }).catchError((erorr){
      print(erorr.toString());
      emit(LoginErorrState(erorr.toString()));
    });
  }
}
