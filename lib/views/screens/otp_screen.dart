import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'dashboard_screen.dart';

class OTPScreen extends StatefulWidget {
  final TextEditingController phone_number;
  const OTPScreen({Key? key, required this.phone_number}) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String text = '';

  void _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  Widget otpNumberWidget(int position) {
    try {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Text(
          text[position],
          style: TextStyle(color: Colors.black),
        )),
      );
    } catch (e) {
      return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(scaffoldBackgroundColor: Colors.teal),
      child: Scaffold(
        // backgroundColor: Colors.white,
        // appBar: AppBar(
        //   leading: IconButton(
        //     icon: Container(
        //       padding: const EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //         borderRadius: const BorderRadius.all(Radius.circular(20)),
        //         color: primaryColor.withAlpha(20),
        //       ),
        //       child: Icon(
        //         Icons.arrow_back_ios,
        //         color: primaryColor,
        //         size: 16,
        //       ),
        //     ),
        //     onPressed: () => Navigator.of(context).pop(),
        //   ),
        //   elevation: 0,
        //   backgroundColor: Colors.white,
        //   brightness: Brightness.light,
        // ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          children: <Widget>[
            Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          'Enter 6 Digits Verification Code Sent To Your Number',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w500))),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        otpNumberWidget(0),
                        otpNumberWidget(1),
                        otpNumberWidget(2),
                        otpNumberWidget(3),
                        otpNumberWidget(4),
                        otpNumberWidget(5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              constraints: const BoxConstraints(maxWidth: 500),

              // child: ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.white, backgroundColor: Colors.red, // foreground
              //   ),
              //   onPressed: () async {
              //     print(text);
              //     APIService api = APIService();
              //     bool correct = await api.otpcheck(widget.phone_number, text);
              //     if (correct) {
              //       bool ch = await api.checkAccountExist();
              //       if (ch) {
              //         Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(builder: (context) => LoginScreen()),
              //         );
              //       } else {
              //         Navigator.pushReplacement(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => RegistrationScreen(),
              //           ),
              //         );
              //       }
              //     } else {
              //       error_toast("Invalid OTP");
              //     }
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: <Widget>[
              //         Text(
              //           'Confirm',
              //           style: TextStyle(color: Colors.white),
              //         ),
              //         Container(
              //           padding: const EdgeInsets.all(8),
              //           decoration: BoxDecoration(
              //             borderRadius:
              //                 const BorderRadius.all(Radius.circular(20)),
              //             color: primaryColor,
              //           ),
              //           child: Icon(
              //             Icons.arrow_forward_ios,
              //             color: Colors.white,
              //             size: 16,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ),
            NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: Colors.white,
              rightIcon: Icon(
                Icons.backspace,
                color: Colors.greenAccent,
              ),
              rightButtonFn: () {
                setState(() {
                  if (text.length > 0) {
                    text = text.substring(0, text.length - 1);
                  }
                });
              },
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                child: Container(
                  height: 140,
                  width: 450,
                  alignment: Alignment.center,
                  child: Image.asset("assets/img/btn3-removebg-preview.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
