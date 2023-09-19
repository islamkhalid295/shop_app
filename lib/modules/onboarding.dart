import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  var pageController = PageController();
  var pageCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Image.asset('lib/images/shopping-cart_.jpg')),
                    SizedBox(
                      height: 30,
                    ),
                    Text("OnBoarding Titel ${index+1}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "OnBoarding Text ${index+1} \n bla bla bla bla ",
                    ),
                  ],
                ),
                itemCount: pageCount,
                controller: pageController,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: JumpingDotEffect(
                    offset: 10,
                    verticalOffset: 10,
                    //jumpScale: 5,
                    activeDotColor: Colors.orangeAccent,
                    dotColor: Colors.grey,
                    spacing: 8.0,
                    radius: 10,
                    dotWidth: 10,
                    dotHeight: 10,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    print(pageController.page?.floor());
                    if ((pageController.page)?.floor() == pageCount-1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopLoginScreen(),
                          ));
                    } else {
                      pageController.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
