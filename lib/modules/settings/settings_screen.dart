import 'package:flutter/material.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/modules/my_account/my_account_screen.dart';
import 'package:my_shopping_app/shared/components/components.dart';
import 'package:my_shopping_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile'),

            //My Account
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical: 15),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: (){
                  navigateTo(
                      context,
                      MyAccountScreen(),
                  );
                },
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: defaultColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text('My Account',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: defaultColor,
                    ),

                  ],
                ),
              ),
            ),

            //Notifications
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical: 15),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: (){},
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      color: defaultColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text('Notifications',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: defaultColor,
                    ),

                  ],
                ),
              ),
            ),

            //Settings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical: 15),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: (){},
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: defaultColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text('Settings',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: defaultColor,
                    ),

                  ],
                ),
              ),
            ),

            //Help Center
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical: 15),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: (){},
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      color: defaultColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text('Help Center',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: defaultColor,
                    ),

                  ],
                ),
              ),
            ),
            //Log Out
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical: 15),
              child: FlatButton(
                padding: EdgeInsets.all(20),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: (){
                  signOut(context);
                },
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: defaultColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text('Log Out',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: defaultColor,
                    ),

                  ],
                ),
              ),
            ),

          ],

        ),
      ),
    );
  }
}
