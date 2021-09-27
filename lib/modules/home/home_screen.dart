import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/layout/bloc_shop/shop_layout_cubit.dart';
import 'package:my_shopping_app/layout/bloc_shop/shop_layout_states.dart';

import 'package:my_shopping_app/models/categories_model.dart';
import 'package:my_shopping_app/models/home_model.dart';
import 'package:my_shopping_app/modules/product_details/product_details.dart';
import 'package:my_shopping_app/shared/components/components.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context, state){
        if(state is ShopSuccessChangeFavoritesState)
        {
          showToast(text: state.model.message, state: ToastStates.SUCCESS);

          if(!state.model.status)
          {
            showToast(text: state.model.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition:ShopLayoutCubit.get(context).homeModel != null && ShopLayoutCubit.get(context).categoriesModel != null,
          builder:(context)=> productsBuilder(ShopLayoutCubit.get(context).homeModel!, ShopLayoutCubit.get(context).categoriesModel!,context) ,
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        ) ;
      },
    );
  }


  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel,context)=> SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(

          items: model!.data!.banners.map((e) =>Image(
            image:NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),).toList() ,
          options: CarouselOptions(
            height: 170.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: defaultColor,
                ),
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoryItem(categoriesModel!.data.data[index]),
                  separatorBuilder: (context, index) => SizedBox(width:10,),
                  itemCount: categoriesModel!.data.data.length,
                ),
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: defaultColor,
                ),

              ),
            ],
          ),
        ),

        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.6,

            children: List.generate(model.data!.products.length, (index) => GestureDetector(child: buildGridProduct( model.data!.products[index],context),onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetails(model.data!.products[index].id)));

            }),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildCategoryItem (DataModel model)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image(
          image: NetworkImage(model.image),
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
      Container(
        color: Colors.black.withOpacity(0.8,),
        width: 100,
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductModel model,context) =>Container(
    color: Colors.white,
    child: Column(

      children: [
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
                      image: NetworkImage(model.image),
                      width: double.infinity,
                      height: 200.0,
                    ),
                    if(model.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        color: Colors.green[500],
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.white,
                          ),
                        ),
                      ),

                  ],
                ),
                IconButton(
                  onPressed: (){},
                  icon:
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey.withOpacity(0.4),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        ShopLayoutCubit.get(context).changeFavorites(model.id);
                        print(model.id);
                      },
                      icon: ShopLayoutCubit.get(context).favorites[model.id]! ?

                      Icon(Icons.favorite,
                        color: Colors.blueAccent,
                        size: 20,
                      ) :
                      Icon(Icons.favorite_outline,
                        color: Colors.blueAccent,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if(model.discount != 0)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.green[100],
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                  child: Text(
                    '${model.discount}% OFF',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),


                ),
              ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3,
                ),
              ),

              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${model.price.round()}',
                    style: TextStyle(
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
                    width: 2.0,
                  ),
                  if(model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}EGP',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                        decoration:TextDecoration.lineThrough,
                      ),
                    ),

                  Spacer(),

                  Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                  Text('4.5',
                    style:TextStyle(
                        color: Colors.amber
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),

      ],
    ),
  );
}
