
import 'package:my_shopping_app/models/cart_model.dart';

abstract class ProductDetailsStates{}
class InitialGetProductsDetailsState extends ProductDetailsStates{}
class LoadingGetProductsDetailsData extends ProductDetailsStates{}
class SuccessGetProductsDetailsData extends ProductDetailsStates{}
class ErrorGetProductsDetailsData extends ProductDetailsStates{}
class ChangeIndicatorState extends ProductDetailsStates{}

class LoadingCart extends ProductDetailsStates{}
class SuccessCart extends ProductDetailsStates{
  final CartModel cart;
  SuccessCart( this.cart);
}
class ErrorCart extends ProductDetailsStates{}
