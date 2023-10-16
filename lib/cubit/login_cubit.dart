import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/home_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class LoginCubit extends Cubit<AppStates> {
  LoginCubit(super.initialState);



  static LoginCubit get(context) => BlocProvider.of(context);

  void login(String email, String password, BuildContext context) {
    emit(LodingState());
    DioHelper.postData(LOGIN, {'email': email, 'password': password})
        .then((value) {
         LoginModel loginModel = LoginModel.fromJson(value.data);
         if (loginModel.status) {
        token = loginModel.data?.token;
        CacheHelper.saveData('token', token).then((value) {

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
          emit(LoginSucssesState());
        });
      }else{
           emit(LoginErorrState(loginModel.message));
         }
         toast(loginModel.message,
             loginModel.status ? Colors.green : Colors.red);

    }).catchError((erorr) {
      emit(LoginErorrState(erorr.toString()));
    });
  }

  void register(String name, String email, String password, String phone, BuildContext context) {
    emit(LodingState());
    DioHelper.postData(REGISTER, {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone
    }).then((value) {
      LoginModel loginModel = LoginModel.fromJson(value.data);
      if (loginModel.status) {
        token = loginModel.data?.token;
        CacheHelper.saveData('token', token).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
          emit(RegisterSucssesState());
        });
      } else {
        emit(RegisterErorrState(loginModel.message));
      }

      toast(loginModel.message, loginModel.status ? Colors.green : Colors.red);
    }).catchError((erorr) {
      emit(RegisterErorrState(erorr.toString()));
    });
  }


}
