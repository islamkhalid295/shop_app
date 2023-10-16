import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_login.dart';
import 'package:shop_app/network/local/cache_helper.dart';
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
                    const SizedBox(
                      height: 30,
                    ),
                    Text("OnBoarding Titel ${index+1}",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(
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
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: const JumpingDotEffect(
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
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if ((pageController.page)?.floor() == pageCount-1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShopLoginScreen(),
                          ));
                      CacheHelper.saveData('onBoarding', true).then((value) {
                      });
                    } else {
                      pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
