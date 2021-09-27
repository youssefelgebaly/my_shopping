import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/modules/login/shop_login_screen.dart';
import 'package:my_shopping_app/modules/my_account/cubit/cubit.dart';
import 'package:my_shopping_app/modules/my_account/cubit/states.dart';
import 'package:my_shopping_app/network/local/cache_helper.dart';
import 'package:my_shopping_app/shared/components/components.dart';
import 'package:my_shopping_app/shared/components/constants.dart';


class MyAccountScreen extends StatelessWidget {

  // var formKey = GlobalKey<FormState>();

  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();


  @override
  Widget build(BuildContext context) {

    emailController.text = ShopUpdateCubit.get(context).profileModel!.data!.email;
    nameController.text = ShopUpdateCubit.get(context).profileModel!.data!.name;
    phoneController.text = ShopUpdateCubit.get(context).profileModel!.data!.phone;
    return BlocProvider(
      create: (BuildContext context)=>ShopUpdateCubit(),
      child: BlocConsumer<ShopUpdateCubit,ShopUpdateStates>(
        listener: (context, state){
          if(state is SuccessUpdate){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Updated Succesfully"),
                  backgroundColor: Colors.green,duration: Duration(milliseconds: 350),
                )
            );
          }
        },
        builder: (context, state)
        {

          return ConditionalBuilder(
            condition: true,
            builder: (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.blueAccent,
                ),

              ),

              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return'name must not be empty';
                          }
                          return null;
                        },
                        label: 'name',
                        prefix: Icons.person_outline,
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return'email must not be empty';
                          }
                          return null;
                        },
                        label: 'Your Email',
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return'phone must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone_outlined,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(function: (){
                        CacheHelper.removeData(key: 'token');
                        token = '';
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShopLoginScreen()));
                      }, text: 'UPDATE')


                    ],
                  ),
                ),
              ),
            ),
            fallback:(context) =>Center(child: CircularProgressIndicator()) ,
          );
        },
      ),
    );
  }

}
