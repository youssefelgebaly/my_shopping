import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/layout/bloc_shop/shop_layout_cubit.dart';
import 'package:my_shopping_app/layout/bloc_shop/shop_layout_states.dart';
import 'package:my_shopping_app/models/categories_model.dart';


class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context, state){},
      builder: (context,state){
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildCategoriesItem(ShopLayoutCubit.get(context).categoriesModel!.data.data[index],context),
          separatorBuilder: (context,index)=> const SizedBox(height: 5,),
          itemCount: ShopLayoutCubit.get(context).categoriesModel!.data.data.length,
        );
      },
    ) ;
  }

  // Widget buildCategoriesItem(DataModel model,context) => InkWell(
  //          onTap:() {
  //            navigateTo(context,
  //                ProductsScreen()
  //            );
  //          },
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //     child: Container(
  //       height: 110,
  //       child: Padding(
  //         padding: const EdgeInsets.all(10.0),
  //         child: Row(
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(15),
  //               child: Image(
  //                 image: NetworkImage(model.image!),
  //                 width: 100,
  //                 height: 100,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //             SizedBox(
  //               width: 15,
  //             ),
  //             Text(
  //               model.name!,
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: defaultColor,
  //               ),
  //             ),
  //             Spacer(),
  //             Icon(
  //                 Icons.arrow_forward_ios,
  //               color: defaultColor,
  //             )
  //           ],
  //         ),
  //       ),
  //       decoration: BoxDecoration(
  //         color: Colors.grey[200],
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //     ),
  //   ),
  // );

  Widget buildCategoriesItem(DataModel model,context)=> Padding(
    padding: const EdgeInsets.symmetric(horizontal:15,vertical: 5),
    child: FlatButton(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: (){},
      color: Colors.grey[200],
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              image: NetworkImage(model.image),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              model.name,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: defaultColor,
          ),

        ],
      ),
    ),
  );

}
