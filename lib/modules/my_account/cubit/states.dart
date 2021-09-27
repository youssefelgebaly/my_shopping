import 'package:my_shopping_app/models/login_model.dart';

abstract class ShopUpdateStates {}

class ShopUpdateInitialState extends ShopUpdateStates{}

// class ShopLoadingUpdateUserState extends ShopUpdateStates {}
// class ShopSuccessUpdateUserState extends ShopUpdateStates
// {
//   final ShopLoginModel loginModel;
//
//   ShopSuccessUpdateUserState(this.loginModel);
// }
// class ShopErrorUpdateUserState extends ShopUpdateStates {}


class LoadingGetProfilesData extends ShopUpdateStates{}
class SuccessGetProfileData extends ShopUpdateStates{}
class ErrorGetProfileData extends ShopUpdateStates{}

class LoadingUpdate extends ShopUpdateStates{}
class SuccessUpdate extends ShopUpdateStates{}
class ErrorUpdate extends ShopUpdateStates{}