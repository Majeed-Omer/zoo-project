import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'register_screen.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({Key? key}) : super(key: key);

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  final controller = PageController();
  bool isLastPage = false;
  String notificationMsg = "Waiting for notifications";
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   LocalNotificationService.initilize();

  //   //Terminated State
  //   FirebaseMessaging.instance.getInitialMessage().then((event) {
  //     if (event != null) {
  //       setState(() {
  //         notificationMsg =
  //             "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
  //       });
  //     }
  //   });

  //   // Foregrand State
  //   FirebaseMessaging.onMessage.listen((event) {
  //     LocalNotificationService.showNotificationOnForeground(event);
  //     setState(() {
  //       notificationMsg =
  //           "${event.notification!.title} ${event.notification!.body} I am coming from foreground";
  //     });
  //   });

  //   // background State
  //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //     setState(() {
  //       notificationMsg =
  //           "${event.notification!.title} ${event.notification!.body} I am coming from background";
  //     });
  //   });
  // }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() => isLastPage = index == 2);
        },
        children: [
          Image.asset('assets/zoo1.png'),
          Image.asset('assets/zoo2.webp'),
          Image.asset('assets/zoo3.jpg'),
        ],
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                  minimumSize: Size.fromHeight(80)),
              onPressed: () async {
                final preferences = await SharedPreferences.getInstance();
                preferences.setBool('showHome', true);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: ((context) => RegisterScreen())));
              },
              child: Text(
                "Get Started",
                style: TextStyle(fontSize: 24),
              ))
          : Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: Text("SKIP")),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.green),
                      onDotClicked: ((index) => controller.animateToPage(index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut)),
                    ),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text("NEXT")),
                ],
              ),
            ),
    );
  }
}
