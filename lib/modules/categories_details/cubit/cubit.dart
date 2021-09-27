import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:my_shopping_app/models/categories_details_model.dart';
import 'package:my_shopping_app/modules/categories_details/cubit/states.dart';
import 'package:my_shopping_app/network/end_points.dart';
import 'package:my_shopping_app/network/remote/dio_helper.dart';
import 'package:my_shopping_app/shared/components/constants.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsStates> {
  CategoryDetailsCubit() : super((InitialGetCategoryDetailsData()));

  static CategoryDetailsCubit get(context) => BlocProvider.of(context);



  CategoryDetailsModel? categoryDetails;
  void getCategoryDetail({
    required int? catId
  }){
    emit(LoadingGetCategoryDetailsData());
    DioHelper.getData(
        url: PRODUCTS,
        token: token,
        query: {
      'category_id':catId,
    }).then((value){
      print(value.data);
      categoryDetails = CategoryDetailsModel.fromJson(value.data);
      print(categoryDetails!.data.data[0].id);
      emit(SuccessGetCategoryDetailsData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetCategoryDetailsData());
    });
  }


}