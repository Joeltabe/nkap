import 'package:flutter/material.dart';
import 'onboard.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset("assets/img/bck.png"),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  height: 300,
                  child: Stack(
                    children: [
                      Image.asset("assets/img/vector_1.png"),
                      Image.asset("assets/img/vector_2.png"),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                    height: 479,
                    width: 440,
                    child: Center(
                        child: Image.asset(
                      "assets/img/lover-removebg-preview 1.png",
                      width: 318,
                      height: 198.5,
                    ))),
              ),
              Spacer(),
              // SizedBox(
              //   height: 200,
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => OnBoard()));
                },
                child: Container(
                  height: 140,
                  width: 290,
                  alignment: Alignment.center,
                  child: Image.asset("assets/img/btn3.png"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
