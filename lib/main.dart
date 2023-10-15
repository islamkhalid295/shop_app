import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/bloc_observer.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/home_screen.dart';
import 'package:shop_app/modules/onboarding.dart';
import 'package:shop_app/modules/shop_login.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? onBoarding = CacheHelper.getData("onBoarding");
  token = CacheHelper.getData("token");
  print(onBoarding);
  Widget myPage;
  if(onBoarding != null)
    {
      if(token != null)
        myPage = HomeScreen();
      else
        myPage = ShopLoginScreen();
    }else{
    myPage = OnBoardingScreen();
  }
  runApp(MyApp(myPage,token));
}

class MyApp extends StatelessWidget {

  Widget myPage;
  String? token;


  MyApp(this.myPage,this.token); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(InitState())..getHomeData()..getCategoriesModel()..getFavoriteData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.orange,
            selectedLabelStyle: TextStyle(color: Colors.orange),
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            // showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,),
        ),
        home: myPage,
      ),
    );
  }
}

