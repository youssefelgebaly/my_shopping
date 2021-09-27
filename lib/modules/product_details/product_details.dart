import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/models/cart_model.dart';
import 'package:my_shopping_app/models/product_model.dart';
import 'package:my_shopping_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ProductDetails extends StatelessWidget {
  final id;

  ProductDetails(this.id);

  var SmoothController = PageController();
  Widget favoriteLoad = Icon(
    Icons.favorite_border,
    color: Colors.blueAccent,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ProductDetailsCubit()..getProductDetails(id.toString()),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
          builder: (context, state) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                  color: defaultColor
              ),
            ),
            body: ProductDetailsCubit.get(context).productDetailsModel ==
                null
                ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: LinearProgressIndicator(
                  color: defaultColor,
                ),
              ),
            )
                : bodyBuild(
                context,
                ProductDetailsCubit.get(context).productDetailsModel,
                SmoothController,ProductDetailsCubit.get(context).cartModel),
            // bottomNavigationBar:
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: defaultButton(function: (){
            //     ProductDetailsCubit.get(context).productDetailsModel;
            //     ProductDetailsCubit.get(context).changeCart(
            //         id: ProductDetailsCubit.get(context).productDetailsModel!.data.id
            //     );
            //   }, text: 'ADD TO CART'),
            // ) ,


          ),
          listener: (context, state) {
            if(state is SuccessCart){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.cart.message.toString()),backgroundColor: Colors.green,duration: Duration(milliseconds: 350),));
            }
            if(state is ErrorCart){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted Succefully"),backgroundColor: Colors.green,duration: Duration(milliseconds: 350),));

            }
          }),
    );
  }
}

Widget bodyBuild(context, ProductDetailsModel? model, SmoothController,CartModel? cartModel) {
  List<Widget> images = [];
  model!.data.images.forEach((element) {
    images.add(Container(
      child: Image.network(element, fit: BoxFit.contain),
    ));
  });
  return ProductDetailsCubit.get(context).productDetailsModel == null
      ? Center(child: CircularProgressIndicator())
      : Container(
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView(
        children: [
          Text(
            model.data.name,
            style: TextStyle(
                fontSize: 25,
              color: Colors.grey[800]
            ),
          ),
          CarouselSlider(
              items: images,
              options: CarouselOptions(
                  height: 300,
                  onPageChanged: (x, reason) {
                    ProductDetailsCubit.get(context).changeVal(x);
                  })),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: AnimatedSmoothIndicator(
                  activeIndex: ProductDetailsCubit.get(context).value,
                  count: images.length),
            ),
          ),
          SizedBox(height: 15,),
          Row(
            children: [
              Text("${model.data.price.toString()} EGP",style: TextStyle(fontSize: 20,color:defaultColor),),
              Spacer(),
              CircleAvatar(child: IconButton(icon: Icon(Icons.add_shopping_cart),onPressed: (){
                ProductDetailsCubit.get(context).changeCart(id: model.data.id);
              },),
                backgroundColor:model.data.inCart? defaultColor: Colors.grey[200],minRadius: 26,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Divider(height: 2,color: defaultColor,endIndent: 10,indent: 10,),
          ),
          SizedBox(height: 15,),
          Text("Description",style: TextStyle(fontSize: 20),),
          SizedBox(height: 15,),
          Text(model.data.description)
        ],
      ),
    ),

  );
}
