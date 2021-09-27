import 'package:my_shopping_app/models/get_cart_model.dart';
import 'package:my_shopping_app/modules/get_cart/cubit/states.dart';
import 'package:my_shopping_app/network/end_points.dart';
import 'package:my_shopping_app/network/remote/dio_helper.dart';
import 'package:my_shopping_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class AllCartsCubit extends Cubit<AllCartsStates> {
  AllCartsCubit() : super((InitialAllCartsCubit()));

  static AllCartsCubit get(context) => BlocProvider.of(context);

  GetCartModel? getCartModel;
  void getAllCarts(){
    emit(LoadinggetAllCarts());
    DioHelper.getData(url: CARTS, token: token).then((value){
      getCartModel = GetCartModel.fromJson(value.data);
      emit(SuccessgetAllCarts());
    }).catchError((error){
      print(error.toString());
      emit(ErrorgetAllCarts());
    });
  }

  void changeCart({required int id}){
    emit(LoadingAllCart());
    DioHelper.postData(url: CARTS, data: {
      'product_id':id
    },token: token).then((value) {
      emit(SuccessAllCart());
      getAllCarts();
    }).catchError((error){
      print(error.toString());
      emit(ErrorAllCart());
    });
  }
}