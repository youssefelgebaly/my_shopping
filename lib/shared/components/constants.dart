import 'package:my_shopping_app/modules/login/shop_login_screen.dart';
import 'package:my_shopping_app/network/local/cache_helper.dart';

import 'components.dart';

void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value) {
    if(value!)
    {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}

void printFullText(String? text)
{
  final pattern=RegExp('.{1.800}');//800 is the size

  pattern.allMatches(text!).forEach((element)=>print(element.group(0)));
}

dynamic token='';