import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:my_shopping_app/layout/shop_layout.dart';
import 'package:my_shopping_app/modules/login/shop_login_screen.dart';
import 'package:my_shopping_app/shared/components/constants.dart';

import 'bloc_observer.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  dynamic onBoardingFinish = false;
  onBoardingFinish = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token', );
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();

  late Widget start;
  if(onBoardingFinish != null){
    if(token == null){
      start = ShopLayout();
    }else{
      start = ShopLoginScreen();
    }
  }else
    start = OnBoardingScreen();
  runApp(MyApp(start));
}
class MyApp extends StatelessWidget {
  final Widget startApp;
  MyApp(this.startApp);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startApp,
    );
  }
}