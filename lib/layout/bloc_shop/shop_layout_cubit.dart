import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/layout/bloc_shop/shop_layout_states.dart';
import 'package:my_shopping_app/models/categories_model.dart';
import 'package:my_shopping_app/models/change_favorites_model.dart';
import 'package:my_shopping_app/models/favorites_model.dart';
import 'package:my_shopping_app/models/home_model.dart';
import 'package:my_shopping_app/models/login_model.dart';
import 'package:my_shopping_app/modules/categories/categories_screen.dart';
import 'package:my_shopping_app/modules/favorites/favorites_screen.dart';
import 'package:my_shopping_app/modules/home/home_screen.dart';
import 'package:my_shopping_app/modules/settings/settings_screen.dart';
import 'package:my_shopping_app/network/end_points.dart';
import 'package:my_shopping_app/network/remote/dio_helper.dart';
import 'package:my_shopping_app/shared/components/constants.dart';


class ShopLayoutCubit extends Cubit<ShopLayoutStates>
{
  ShopLayoutCubit() : super(ShopInitialState());

  static ShopLayoutCubit get(context) =>BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreen=
  [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex= index;
    emit(ShopChangeBottomNavState());
  }


  HomeModel? homeModel;

  Map<int, bool> favorites={};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel=HomeModel.fromJson(value.data);

      // printFullText(homeModel!.data!.banners[0].image);
      // print(homeModel!.status);

      homeModel!.data!.products.forEach((element)
      {
        favorites.addAll({
          element.id:element.inFavorites,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories()
  {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel=CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites( int productId)
  {
    emit(ShopLoadingChangeFavoritesState());
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value){
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if(!changeFavoritesModel!.status )
      {
        favorites[productId] = !favorites[productId]!;
      }else
      {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){

      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorFavoritesState(error.toString()));
    });
  }


  FavoritesModel? favoritesModel;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;
  void getUserData()
  {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,

      token: token!,

    ).then((value)
    {
      userModel=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}