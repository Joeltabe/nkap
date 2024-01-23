import 'package:nkap/views/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String first_name, last_name, email, nid, pin;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Theme(
        data: Theme.of(context).copyWith(scaffoldBackgroundColor: Colors.teal),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(color: Colors.green),
                Center(
                  child: Container(
                      height: 179,
                      width: 240,
                      child: Center(
                          child: Image.asset(
                        "assets/img/lover-removebg-preview 1.png",
                        width: 318,
                        height: 198.5,
                      ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 10),
                  child: Text(
                    "Into Your nkap Wallet",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       TextField(
                //         decoration: InputDecoration(
                //             hintText: "+8801774000000", labelText: "Phone Number"),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (val) {
                          setState(() {
                            last_name = val;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Username",
                          labelText: "UserName",
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (val) {
                          setState(() {
                            first_name = val;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "******",
                          labelText: "Enter Pin",
                          prefixIcon: Icon(Icons.pin), // Add the icon here
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 35,
                ),
                // Center(
                //   child: ElevatedButton(
                //     child: Container(
                //       alignment: Alignment.center,
                //       height: 50,
                //       width: 250,
                //       child: Text(
                //         'Register',
                //         style: TextStyle(
                //             fontSize: 17,
                //             fontWeight: FontWeight.w500,
                //             color: Colors.white),
                //       ),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       elevation: 10,
                //       backgroundColor: Colors.green,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onPressed: () async {
                //       // APIService api = APIService();
                //       // bool ch = await api.customerRegister(
                //       //     first_name: first_name,
                //       //     email: email,
                //       //     last_name: last_name,
                //       //     pin: pin,
                //       //     nid: nid);
                //       MaterialPageRoute(builder: (context) => LoginScreen());
                //       // if (ch) {
                //       //   Navigator.push(context,
                //       //       MaterialPageRoute(builder: (context) => LoginScreen()));
                //       // } else {}
                //     },
                //   ),
                // ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                    child: Container(
                      height: 120,
                      width: 790,
                      alignment: Alignment.center,
                      child:
                          Image.asset("assets/img/btn3-removebg-preview.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
