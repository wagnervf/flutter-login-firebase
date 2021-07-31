import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';

// ignore: use_key_in_widget_constructors
class BodySplash extends StatefulWidget {
  @override
  _BodySplashState createState() => _BodySplashState();
}

class _BodySplashState extends State<BodySplash> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Tokoto. Let's shop!",
      "image": "assets/images/splash_1.png",
    },
    {
      "text": "We help people conect with core!",
      "image": "assets/images/splash_2.png",
    },
    {
      "text": "We show the easy way to shop.",
      "image": "assets/images/splash_3.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      // ignore: sized_box_for_whitespace
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  title: "TOKOTO",
                  text: splashData[index]["text"]!,
                  image: splashData[index]["image"]!,
                ),
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    buildButton(context),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  SizedBox buildButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getHeight(context) * .09,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(
          "Continue",
          style: TextStyle(
              fontSize: getHeight(context) * .03, color: Colors.white),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String title;
  final String text;
  final String image;

  // ignore: use_key_in_widget_constructors
  const SplashContent({
    required this.title,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          title,
          style: TextStyle(
            fontSize: getProportionateScreenHeight(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(256),
          width: getProportionateScreenWidth(235),
        )
      ],
    );
  }
}
