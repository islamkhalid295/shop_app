import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/product_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/categories_screen.dart';
import 'package:shop_app/modules/favorite_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settings_screen.dart';
import 'package:shop_app/modules/shop_login.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit(super.initialState);

  int currentIndex = 0;
  static AppCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    const SettingsScreen(),
  ];

  void changeBottom (int index)
  {
    currentIndex = index;
    emit(BottomNavBarState());
  }
  Map<int,bool> inFavorite = {};
  static HomeModel? homeModel;
  void getHomeData() {
    emit(LodingState());
    DioHelper.getData(HOME,token: token).then((value) {
      homeModel= HomeModel.fromJson(value.data);
      homeModel?.data.products.forEach((element) {
        inFavorite.addAll({element.id: element.in_favorites,});
      });
      emit(HomeDataSucssesState());
    }).catchError((error){
      emit(HomeDataErorrState(error));
    });
  }

  static CategoriesModel? categoriesModel;
  void getCategoriesModel() {
    emit(LodingState());
    DioHelper.getData(CATEGORIES).then((value) {
      categoriesModel= CategoriesModel.fromJson(value.data);
      emit(CategoriesDataSucssesState());
    }).catchError((error){
      emit(CategoriesDataErorrState(error));
    });
  }

  void changeFavorite(int id){
    inFavorite[id] = !inFavorite[id]!;
    emit(FavoriteChangeSucssesState());
    FavoriteChangeModel model;
    DioHelper.postData(
      FAVORITES,
      {"product_id" : id},
      token: token,
    ).then((value) {
      model = FavoriteChangeModel.fromJson(value.data);
      if(!model.status){
        inFavorite[id] = !inFavorite[id]!;
        toast(model.message, Colors.red);
      }
      emit(FavoriteChangeSucssesState());
    }).catchError((error){
      inFavorite[id] = !inFavorite[id]!;
      toast(error.toString(), Colors.red);
      FavoriteChangeErorrState(error);
    });
  }

  static FavoriteModel? favoriteModel;
  void getFavoriteData() {
    emit(LodingState());
    DioHelper.getData(FAVORITES,token: token).then((value) {
      favoriteModel= FavoriteModel.fromJson(value.data);
      emit(FavoriteDataSucssesState());
    }).catchError((error){
      emit(FavoriteDataErorrState(error));
    });
  }
  void logOut (context){
    CacheHelper.remove('token').then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShopLoginScreen(),));
    });
  }
  LoginModel? loginModel;
  void getProfile(){
    emit(LodingGetProfileState());
    DioHelper.getData(PROFILE,token: token).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(GetProfileDataSucssesState());
    });
  }
  SearchModel? searchModel;
  void search(String text){
    emit(SearchLodingState());
    DioHelper.postData(SEARCH,{
      "text": text,
    },token: token).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchDataSucssesState());
    });
  }

}