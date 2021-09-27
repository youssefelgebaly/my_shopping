import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/models/login_model.dart';
import 'package:my_shopping_app/models/profile_model.dart';
import 'package:my_shopping_app/modules/my_account/cubit/states.dart';
import 'package:my_shopping_app/network/end_points.dart';
import 'package:my_shopping_app/network/remote/dio_helper.dart';
import 'package:my_shopping_app/shared/components/constants.dart';

class ShopUpdateCubit extends Cubit<ShopUpdateStates>
{
  ShopUpdateCubit() : super(ShopUpdateInitialState());

  static ShopUpdateCubit get(context)=>BlocProvider.of(context);

  ProfileModel? profileModel;
  void getProfile(){
    emit(LoadingGetProfilesData());
    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value){
      profileModel = ProfileModel.fromJson(value.data);
      printFullText(profileModel!.data!.name);

      emit(SuccessGetProfileData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetProfileData());
    });
  }

  void updateData({required String email,required String name,required String phone,}){
    emit(LoadingUpdate());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
      'name':name,
      'email':email,
      'phone':phone,
    },
    ).then((value) {
      getProfile();
      emit(SuccessUpdate());
    }).catchError((error){
      emit(ErrorUpdate());
    });
  }
}
