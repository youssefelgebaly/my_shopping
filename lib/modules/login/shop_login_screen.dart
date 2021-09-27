import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/layout/shop_layout.dart';
import 'package:my_shopping_app/modules/register/shop_register_screen.dart';
import 'package:my_shopping_app/network/local/cache_helper.dart';
import 'package:my_shopping_app/shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {

  var formKey=GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController=TextEditingController();

  ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context,state){
          if(state is ShopLoginSuccessState)
          {
            if(state.loginModel.status!)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value){
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
        },
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title:
              Center(child: Text(
                'Sing In',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.normal
                ),
              ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                                'Welcome Back!',
                                style: Theme.of(context).textTheme.headline4!.copyWith(
                                  color: defaultColor,
                                ),
                              ),
                              Text(
                                ' Please login to your account ',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color:Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'please enter your email address';
                            }
                          },
                          label: 'Enter your email',
                          prefix: Icons.email_outlined,
                        ),

                        const SizedBox(
                          height: 15.0 ,
                        ),

                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffixPressed: (){

                            ShopLoginCubit.get(context).changePasswordVisibility();

                          },

                          onSubmit:(value){
                            if(formKey.currentState!.validate())
                            {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          } ,
                          validate: (value){
                            if(value!.isEmpty){
                              return 'password is too short';
                            }
                          },
                          label: 'Enter your password',
                          prefix: Icons.lock_outline,
                        ),



                      const SizedBox(
                          height: 30.0 ,
                        ),

                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: remember,
                        //       activeColor: defaultColor,
                        //       onChanged: (value) {
                        //          {
                        //            setState(() {
                        //              remember = value;
                        //            });
                        //         }
                        //       },
                        //     ),
                        //     Text("Remember me"),
                        //     Spacer(),
                        //     Text(
                        //         'Forget Password   ',
                        //       style: TextStyle(decoration: TextDecoration.underline),
                        //
                        //
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10.0 ,
                        // ),

                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState ,
                          builder:(context)=>defaultButton(
                            function: (){
                              if(formKey.currentState!.validate())
                              {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LOGIN',
                            isUpperCase: true,
                          ),
                          fallback:(context)=>const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15.0 ,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Center(
                              child: Text(
                                'Don\'t have an account?',
                              ),
                            ),


                            defaultTextButtom(
                                function: ()
                                {
                                  navigateTo(
                                    context,
                                    ShopRegisterScreen(),
                                  );
                                },
                                text: 'register'
                            ),
                          ],
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

void setState(Null Function() param0) {
}
