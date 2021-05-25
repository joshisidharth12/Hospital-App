import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/screens/onboarding/OnBoardingScreen.dart';
import 'package:hospital_app/screens/sign_up_screen/SignUpOption.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingBody extends StatefulWidget {

  @override
  _OnBoardingBodyState createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  int currentpage = 0;
  PageController pageController;

  List<Map<String, String>> onBoardingPages = [
    {
      'text1': 'View and buy\nMedicine online',
      'text2': 'Etiam mollis metus non purus\nfaucibus sollicitudin. Pellentesque sagittis mi. Integer.',
      'image': 'assets/images/buymeds.png'
    },
    {
      'text1': 'Online medical &\nHealthcare',
      'text2': 'Etiam mollis metus non purus\nfaucibus sollicitudin. Pellentesque sagittis mi. Integer.',
      'image': 'assets/images/online.png'
    },
    {
      'text1': 'Get Delivery on time',
      'text2': 'Etiam mollis metus non purus\nfaucibus sollicitudin. Pellentesque sagittis mi. Integer.',
      'image': 'assets/images/delivery.png'
    },
  ];

  @override
  void initState()   {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentpage = value;
                  });
                },
                itemCount: onBoardingPages.length,
                itemBuilder: (context, index) => OnBoardingContent(
                  text1: onBoardingPages[index]['text1'],
                  text2: onBoardingPages[index]['text2'],
                  image: onBoardingPages[index]['image'],
                )
            ),
          ),

          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: Text("Skip",
                    style: TextStyle(color: Colors.grey[400],fontSize: getProportionateScreenHeight(14))),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onBoardingPages.length,
                          (index) => buildDot(index: index),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      if(pageController.hasClients ){
                        pageController.animateToPage(currentpage+1, duration: kAnimationDuration, curve: Curves.easeInOut);
                      }
                      if(currentpage == 2){
                        Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,
                            duration: kAnimationDuration, child: SignUpOption()));

                      }

                    },
                    child: Text(
                      currentpage == 2 ? "Sign up" : "Next",
                      style: TextStyle(color: Color(0xFF4157FF),fontSize: getProportionateScreenHeight(14)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: 6,
      decoration: BoxDecoration(
          color: currentpage == index ? kPrimaryColor : Color(0xFFD8D8D8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
