
import 'package:my_shopping_app/models/change_favorites_model.dart';
import 'package:my_shopping_app/models/login_model.dart';

abstract class ShopLayoutStates {}

class ShopInitialState extends ShopLayoutStates{}

class ShopChangeBottomNavState extends ShopLayoutStates{}

class ShopLoadingHomeDataState extends ShopLayoutStates{}
class ShopSuccessHomeDataState extends ShopLayoutStates{}
class ShopErrorHomeDataState extends ShopLayoutStates {}

class ShopLoadingCategoriesState extends ShopLayoutStates{}
class ShopSuccessCategoriesState extends ShopLayoutStates{}
class ShopErrorCategoriesState extends ShopLayoutStates {}

class ShopLoadingChangeFavoritesState extends ShopLayoutStates{}
class ShopChangeFavoritesState extends ShopLayoutStates{}
class ShopSuccessChangeFavoritesState extends ShopLayoutStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorFavoritesState extends ShopLayoutStates
{
  final String error;

  ShopErrorFavoritesState (this.error);
}

class ShopLoadingGetFavoritesState extends ShopLayoutStates{}
class ShopSuccessGetFavoritesState extends ShopLayoutStates{}
class ShopErrorGetFavoritesState extends ShopLayoutStates {}

class ShopLoadingUserDataState extends ShopLayoutStates {}
class ShopSuccessUserDataState extends ShopLayoutStates {}
class ShopErrorUserDataState extends ShopLayoutStates {}

class ShopLoadingUpdateUserState extends ShopLayoutStates {}
class ShopSuccessUpdateUserState extends ShopLayoutStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}
class ShopErrorUpdateUserState extends ShopLayoutStates {}
