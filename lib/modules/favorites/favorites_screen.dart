import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/layout/bloc_shop/shop_layout_cubit.dart';
import 'package:my_shopping_app/layout/bloc_shop/shop_layout_states.dart';
import 'package:my_shopping_app/models/favorites_model.dart';
import 'package:my_shopping_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context, state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState ,
          builder:(context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index)=>GestureDetector(child: buildFavoritesItem(ShopLayoutCubit.get(context).favoritesModel!.data!.data![index],context),
            onTap:(){},
            ),
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: ShopLayoutCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback:(context)=> Center(child: CircularProgressIndicator(),) ,
        );
      },
    ) ;
  }

  Widget buildFavoritesItem(FavoritesData model, context) =>Padding(
    padding: const EdgeInsets.all(15.0),
    child: Container(
      height: 120,
      child: Row(
          children:[
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage(model.product!.image),
                          width: 120,
                          height: 120,
                        ),
                        if(model.product!.discount != 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            color: Colors.green[500],
                            child: const Text(
                              'DISCOUNT',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Colors.white,
                              ),
                            ),
                          ),

                      ],
                    ),
                  ],
                ),
                if(model.product!.discount != 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.green[100],
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        '${model.product!.discount} % OFF',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),


                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${model.product!.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: defaultColor,
                          ),
                        ),
                        Text(
                          'EGP',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),

                        if(model.product!.discount != 0)

                          Text(
                            '${model.product!.oldPrice}EGP',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              decoration:TextDecoration.lineThrough,
                            ),
                          ),




                        Spacer(),

                        IconButton(
                          onPressed: (){},
                          icon:
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.withOpacity(0.4),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                ShopLayoutCubit.get(context).changeFavorites(model.product!.id);
                                print(model.id);
                              },
                              icon: ShopLayoutCubit.get(context).favorites[model.product!.id]! ?

                              Icon(Icons.favorite,
                                color: Colors.blueAccent,
                                size: 20,
                              )
                                  :
                              Icon(Icons.favorite_outline,
                                color: Colors.blueAccent,
                                size: 20,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],

                ),
              ),
            ),
          ]
      ),
    ),
  );

}
