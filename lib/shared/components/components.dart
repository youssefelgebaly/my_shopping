import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/layout/bloc_shop/shop_layout_cubit.dart';
import 'package:my_shopping_app/models/search_model.dart';
import 'package:my_shopping_app/modules/product_details/product_details.dart';

void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget)
);

void navigateAndFinish(context, widget,) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
      builder: (context)=>widget
  ),
      (route)
  {
    return false;
  },
);
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget defaultFormField({
  required TextEditingController controller,
  Function (String ?)? onSubmit,
  Function? onChange,
  required String? Function(String?) validate,
  TextInputType? type,
  bool isPassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: (s){
        onSubmit!(s);
      },



      validator:(value)
      {
        return validate(value);
      },

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? IconButton(
          onPressed: (){
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        ):null,
        border: OutlineInputBorder(
          borderRadius:BorderRadius.circular(30.0),
        ),
      ),


    );

Widget defaultButton({
  double width =double.infinity ,
  Color background =Colors.blue,
  bool isUpperCase =true,
  double radius= 4.0,
  required Function() function,
  required String text,
})=> Container(
  width: width,
  height: 54.0,
  child: MaterialButton(
    onPressed:function,
    child: Text (
      isUpperCase ? text.toUpperCase():text,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius:BorderRadius.circular(50),
    color: background,
  ),

);


Widget defaultTextButtom({
  required Function() function,
  required String text,
})=>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );


void showToast({
  required String? text,
  required ToastStates state,
})=>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// لما يكون عندك كذا اختيار من الحاجة enum

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildListProduct(
    model,
    index,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      // Spacer(),
                      // IconButton(
                      //   onPressed: (){},
                      //   icon:
                      //   CircleAvatar(
                      //     radius: 12,
                      //     backgroundColor: Colors.grey.withOpacity(0.4),
                      //     child: IconButton(
                      //       padding: EdgeInsets.zero,
                      //       onPressed: (){
                      //         ShopLayoutCubit.get(context).changeFavorites(model.product!.id);
                      //         print(model.id);
                      //       },
                      //       icon: ShopLayoutCubit.get(context).favorites[model.product!.id]! ?
                      //
                      //       Icon(Icons.favorite,
                      //         color: Colors.blueAccent,
                      //         size: 20,
                      //       )
                      //           :
                      //       Icon(Icons.favorite_outline,
                      //         color: Colors.blueAccent,
                      //         size: 20,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
