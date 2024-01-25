import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import 'otp_screen.dart';

class InitialLogin extends StatefulWidget {
  const InitialLogin({Key? key}) : super(key: key);

  @override
  _InitialLoginState createState() => _InitialLoginState();
}

class _InitialLoginState extends State<InitialLogin> {
  final TextEditingController phoneController = TextEditingController();
  late TextEditingController phone_number = phoneController;
  Country selectedCountry = Country(
      phoneCode: "237",
      countryCode: "CM",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "cameroon",
      example: "cameroon",
      displayName: "cameroon",
      displayNameNoCountryCode: "CMR",
      e164Key: "");
  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    return Theme(
      data: Theme.of(context).copyWith(scaffoldBackgroundColor: Colors.teal),
      child: Scaffold(
        // isRoot: true,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 180),
                Center(
                  child: Container(
                      padding: EdgeInsets.all(12),
                      height: 179,
                      width: 240,
                      child: Image.asset(
                          "assets/img/lover-removebg-preview 1.png")),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Register / Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 10),
                      child: Text(
                        "Into Your Nkap Wallet",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                      child: TextFormField(
                        cursorColor: Colors.lightGreen,
                        controller: phoneController,
                        onChanged: (value) {
                          setState(() {
                            phoneController.text = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter your number",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black12),
                          ),
                          prefixIcon: Container(
                            padding: EdgeInsets.all(9.0),
                            child: InkWell(
                              onTap: () {
                                showCountryPicker(
                                    context: context,
                                    countryListTheme: CountryListThemeData(
                                      bottomSheetHeight: 550,
                                    ),
                                    onSelect: (value) {
                                      setState(() {
                                        selectedCountry = value;
                                      });
                                    });
                              },
                              child: Text(
                                "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          suffixIcon: phoneController.text.length > 8
                              ? Container(
                                  height: 30,
                                  width: 30,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                  child: const Icon(
                                    Icons.done,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )
                              : null,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.all(9.0),
                        //         child: InkWell(
                        //           onTap: () {
                        //             showCountryPicker(
                        //                 context: context,
                        //                 countryListTheme: CountryListThemeData(
                        //                   bottomSheetHeight: 550,
                        //                 ),
                        //                 onSelect: (value) {
                        //                   setState(() {
                        //                     selectedCountry = value;
                        //                   });
                        //                 });
                        //           },
                        //           child: Text(
                        //             "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                        //             style: TextStyle(
                        //                 fontSize: 18,
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPScreen(
                                        phone_number: phone_number,
                                      )));
                        },
                        child: Container(
                          height: 140,
                          width: 450,
                          alignment: Alignment.center,
                          child: Image.asset(
                              "assets/img/btn3-removebg-preview.png"),
                        ),
                      ),
                    ),
                    // CustomPrimaryButton(
                    //     btnText: "Continue",
                    //     onTap: () async {
                    //       APIService api = APIService();
                    //       bool ch = await api.login(phone_number);
                    //       if (ch) {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => OTPScreen(
                    //                       phone_number: phone_number,
                    //                     )));
                    //       }
                    //     })
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
