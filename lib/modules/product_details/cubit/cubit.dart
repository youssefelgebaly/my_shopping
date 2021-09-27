import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:my_shopping_app/models/cart_model.dart';
import 'package:my_shopping_app/models/product_model.dart';
import 'package:my_shopping_app/modules/product_details/cubit/states.dart';
import 'package:my_shopping_app/network/end_points.dart';
import 'package:my_shopping_app/network/remote/dio_helper.dart';
import 'package:my_shopping_app/shared/components/constants.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  ProductDetailsCubit() : super((InitialGetProductsDetailsState()));

  static ProductDetailsCubit get(context) => BlocProvider.of(context);

  ProductDetailsModel? productDetailsModel;

  void getProductDetails(String id){
    emit(LoadingGetProductsDetailsData());
    DioHelper.getData(
        url: "${PRODUCTSDETAILS+id}",
        token: token
    ).then((value){
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      emit(SuccessGetProductsDetailsData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetProductsDetailsData());
    });
  }

  int value = 0;
  void changeVal(val){
    value = val;
    emit(ChangeIndicatorState());
  }

  bool isCart = false;
  CartModel? cartModel;
  void changeCart({required int id}){
    emit(LoadingCart());
    DioHelper.postData(
        url: CARTS,
        data: {
          'product_id':id
        },
        token: token
    ).then((value) {
      getProductDetails(id.toString());
      cartModel = CartModel.fromJson(value.data);
      emit(SuccessCart(cartModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorCart());
    });
  }
}