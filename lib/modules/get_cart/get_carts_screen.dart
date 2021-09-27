import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/models/get_cart_model.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class GetCartsScreen extends StatelessWidget {
  const GetCartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>AllCartsCubit()..getAllCarts(),
        child: BlocConsumer<AllCartsCubit,AllCartsStates>(
          builder:(context,state)=>Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(
                  color: defaultColor,
              ),
            ),

            body: AllCartsCubit.get(context).getCartModel == null? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(child: LinearProgressIndicator(color: defaultColor,)),
            ) :AllCartsCubit.get(context).getCartModel!.data.cartItems.isEmpty?
            Center(
                child: Text(
                  "Your cart is Empty",
                  style: TextStyle(
                    color: Colors.green[400],
                    fontSize: 25,
                  ),
                ),
            ) :
            ListView(
              children: [
                Container(
                  color: Colors.grey[200],
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 1,
                    children: List.generate(
                        AllCartsCubit.get(context).getCartModel!.data.cartItems.length,
                            (index) => productsView(AllCartsCubit.get(context).getCartModel,index,context)
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),

                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: "Total:\n",
                                children: [
                                  TextSpan(
                                    text: "${AllCartsCubit.get(context).getCartModel!.data.total} EGP",
                                    style: TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 210,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  primary: Colors.white,
                                  backgroundColor: defaultColor,
                                ),
                                onPressed: (){},
                                child: Text(
                                  'Check out Card',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
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
              ],
            ),

          ),
          listener: (context,state){
            if(state is SuccessAllCart){
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Deleted Succefully"),
                    backgroundColor: Colors.green,
                    duration: Duration(milliseconds: 350),
                  ),
              );
            }
          },
        ));
  }
}
Widget productsView(GetCartModel? model,index,context){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.5,vertical: 0.5),
    child: Container(
      decoration: BoxDecoration(
        color:Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(child: Image.network(model!.data.cartItems[index].product.image,
              width: 280
              ,
            )),
            Text(model.data.cartItems[index].product.name),
            SizedBox(height: 5,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text("${model.data.cartItems[index].product.price.toString()} EGP",
                    style: TextStyle(color: Colors.blueAccent),),
                ),
                Spacer(),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(children: [
                      Icon(Icons.restore_from_trash,color: Colors.red,),
                      Text("Remove from cart",style: TextStyle(color: Colors.red),)
                    ],),
                  ),
                  onTap: (){
                    print(model.data.cartItems[index].id);
                    AllCartsCubit.get(context).changeCart(id: model.data.cartItems[index].product.id);
                  },
                ),
              ],
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    ),
  );
}

