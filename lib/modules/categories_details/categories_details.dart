import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/models/categories_details_model.dart';
import 'package:my_shopping_app/modules/categories_details/cubit/states.dart';

import 'cubit/cubit.dart';

class CategoryDetails extends StatelessWidget {
  final int? id;
  const CategoryDetails({required this.id});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>CategoryDetailsCubit()..getCategoryDetail(catId: this.id),)
      ],

      child: BlocConsumer<CategoryDetailsCubit,CategoryDetailsStates>(
        builder:(context,state)=>Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: defaultColor),),
          body: CategoryDetailsCubit.get(context).categoryDetails == null? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Center(child: LinearProgressIndicator(color: defaultColor,)),
          ) :
          Container(
            color: Colors.grey[200],
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(CategoryDetailsCubit.get(context).categoryDetails!.data.data.length, (index) => productsView(CategoryDetailsCubit.get(context).categoryDetails,index,context)),),
          ),),
        listener: (context,state){
          if(state is SuccessGetCategoryDetailsData)
          {

          }
        },
      ),
    );
  }
}
Widget productsView(CategoryDetailsModel? model,index,context){
  return GestureDetector(
    onTap: (){
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(
      //     model!.data.data[index].id
      // )));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.5,vertical: 0.5),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(child: Image.network(model!.data.data[index].image)),
              Text(model.data.data[index].name),
              SizedBox(height: 5,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("${model.data.data[index].price.toString()} EGP",style: TextStyle(color: defaultColor),),
                  ),
                  model.data.data[index].discount !=0 ? Text(model.data.data[index].oldPrice.toString(),style: TextStyle(color: Colors.grey[400],decoration: TextDecoration.lineThrough),):Text(""),
                ],
              ),
              SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    ),
  );
}