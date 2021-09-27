import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/modules/get_cart/get_carts_screen.dart';
import 'package:my_shopping_app/modules/search/search_screen.dart';
import 'package:my_shopping_app/shared/components/components.dart';

import 'bloc_shop/shop_layout_cubit.dart';
import 'bloc_shop/shop_layout_states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLayoutCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
      child: BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener: (context,state){},
        builder: (context,state){

          var cubit=ShopLayoutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'My Shopping',
                style: TextStyle(
                  color: defaultColor,
                ),

              ),

              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context,
                        SearchScreen());
                  },
                  icon:const Icon(
                    Icons.search,
                    color: defaultColor,
                  ),
                ),
                IconButton(
                  onPressed: (){
                    navigateTo(context,
                        const GetCartsScreen(),
                    );
                  },
                  icon:const Icon(
                    Icons.shopping_cart_outlined,
                    color: defaultColor,
                  ),
                ),
              ],
            ),
            body:cubit.bottomScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: defaultColor,
              unselectedItemColor: Colors.grey,
              onTap:(index)
              {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items:
              const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.widgets_sharp,
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'settings ',
                ),


              ],
            ),

          );
        },
      ),
    );



  }
}
