import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class LoginCubit extends Cubit<AppStates> {
  LoginCubit(super.initialState);
  String test  = 'ssd';
  static LoginCubit get(context) => BlocProvider.of(context);
  void login (String email, String password){
    print(email+password);
    emit(LodingState());
    DioHelper.postData('login', {'email':email, 'password':password}).then((value) {

      print(value.data);
      emit(LoginSucssesState());
    }).catchError((erorr){
      print(erorr.toString());
      emit(LoginErorrState(erorr.toString()));
    });
  }
}