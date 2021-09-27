import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_shopping_app/Styles/colors.dart';
import 'package:my_shopping_app/modules/login/shop_login_screen.dart';
import 'package:my_shopping_app/network/local/cache_helper.dart';
import 'package:my_shopping_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });

}


class OnBoardingScreen extends StatefulWidget
{
  const OnBoardingScreen({Key? key}) : super(key: key);


  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController=PageController();

  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'Faster App Shopping',
        body: 'Every product you want will be with you faster'
    ),
    BoardingModel(
        image: 'assets/images/onboard_2.jpg',
        title: 'Faster App Shopping',
        body: 'Every product you want will be with you faster'
    ),
    BoardingModel(
        image: 'assets/images/onboard_3.jpg',
        title: 'Faster App Shopping',
        body: 'Every product you want will be with you faster'
    ),
  ];
   bool isList = false;
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: false).then((value){
      if(value!)
      {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          defaultTextButtom(
            function: submit,
            text: 'Skip',
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged:(int index)
                {
                  if(index==boarding.length-1)
                  {
                    setState(() {
                      isList=true;
                    });
                  }else
                  {
                    setState(() {
                      isList=false;
                    });
                  }
                },
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: boarding.length

                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(isList)
                    {
                      submit();
                    }else
                    {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child:const Icon(Icons.arrow_forward_outlined,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image),

        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
