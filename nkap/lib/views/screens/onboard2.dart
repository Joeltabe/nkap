import 'package:flutter/material.dart';
import 'register_screen.dart';

class OnBoarder extends StatefulWidget {
  const OnBoarder({Key? key}) : super(key: key);

  @override
  _OnBoarder createState() => _OnBoarder();
}

class _OnBoarder extends State<OnBoarder> {
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
                  height: 179,
                  width: 240,
                  child: Center(
                      child: Image.asset(
                          "assets/img/Njangi_bag-removebg-preview 1.png")),
                ),
              ),

              Center(
                  child: Container(
                height: 179,
                width: 440,
                alignment: Alignment.center,
                child: Text(
                    "Empower your financial journey with our NKAP app where every penny counts, and your financial goals become achievable realities. "
                        .toUpperCase(),
                    style: TextStyle(
                        height: 2,
                        wordSpacing: 1,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87.withOpacity(0.6))),
              )),

              Spacer(),
              // SizedBox(
              //   height: 200,
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()));
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
