import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/models/login_model.dart';
import 'package:my_shopping_app/modules/login/cubit/states.dart';
import 'package:my_shopping_app/network/end_points.dart';
import 'package:my_shopping_app/network/remote/dio_helper.dart';
class ShopLoginCubit extends Cubit<ShopLoginState>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email':email,
        'password':password,
      },
    ).then((value){
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){

      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPassword =true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix=isPassword ?Icons.visibility_off_outlined:Icons.visibility_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}