import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/layout/shop_layout.dart';
import 'package:my_shopping_app/network/local/cache_helper.dart';
import 'package:my_shopping_app/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class ShopRegisterScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController=TextEditingController();
  var phoneController = TextEditingController();
  var passwordAgainController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener:(context, state){
          if(state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel.data!.token).then((value)
              {
                //token=state.loginModel.data!.token;
                navigateAndFinish(
                  context,
                  ShopLayout(),
                );
              });
              showToast(
                text: state.loginModel.message,
                state: ToastStates.SUCCESS,
              );
            }else
            {

              print(state.loginModel.message);

              showToast(
                text: state.loginModel.message,
                state:ToastStates.ERROR,
              );
            }
          }
        } ,
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.blueAccent,
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'Let\'s get started !',
                                style: Theme.of(context).textTheme.headline4!.copyWith(
                                  color: defaultColor,
                                ),
                              ),
                              Text(
                                'Create an account to get all features  ',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color:Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your user name';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person_outline,
                        ),

                        SizedBox(
                          height: 15.0 ,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),

                        SizedBox(
                          height: 15.0 ,
                        ),

                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your phone number';
                            }
                          },
                          label: 'Phone number ',
                          prefix: Icons.phone_outlined,
                        ),

                        SizedBox(
                          height: 15.0 ,
                        ),

                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: (){

                            ShopRegisterCubit.get(context).changePasswordVisibility();

                          },

                          onSubmit:(value){
                            if(formKey.currentState!.validate())
                            {
                              ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          } ,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'password is too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),

                        SizedBox(
                          height: 15.0 ,
                        ),
                        defaultFormField(
                          controller: passwordAgainController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          isPassword: ShopRegisterCubit.get(context).isPassword,
                          suffixPressed: (){

                            ShopRegisterCubit.get(context).changePasswordVisibility();

                          },

                          onSubmit:(value){
                            if(formKey.currentState!.validate())
                            {
                              ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          } ,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'This field must not be empty';
                            }else if(value != passwordController.text){
                              return "The password is not the same";
                            }
                          },
                          label: 'Confirm Password',
                          prefix: Icons.lock_outline,
                        ),



                        SizedBox(
                          height: 30.0 ,
                        ),


                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState ,
                          builder:(context)=>defaultButton(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'SING UP',
                            isUpperCase: true,
                          ),
                          fallback:(context)=>Center(child: CircularProgressIndicator()),
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );


  }
}
