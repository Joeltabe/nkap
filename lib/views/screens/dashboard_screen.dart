import 'package:nkap/logics/models/profile.dart';
import 'package:nkap/logics/services/API/api_helper.dart';
import 'package:nkap/views/components/constant.dart';
import 'package:nkap/views/components/pie_chart.dart';
import 'package:nkap/views/components/reuseable_widgets.dart';
import 'package:nkap/views/screens/send_money_screen.dart';

import 'package:flutter/material.dart';
import 'add _money.dart';
import 'bill_payment_screen.dart';
import 'cash_out_screen.dart';
import 'mobile_recharge_screen.dart';
import 'user_profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Profile profile;
  bool isLoading = true;
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Profile'),
    Text('Groups'),
    Text('Chat'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    Dashboard(),
    UserProfile(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  Future<void> getdata() async {
    APIService api = APIService();
    var data = await api.getProfileData();
    String loc = await api.getLocationCity();
    print(loc.toUpperCase());

    profile = Profile.fromJson(data);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('NKAP'),
      ),
      drawer: MyDrawer(),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.topRight,
          color: Colors.teal,
          child: Column(
            children: [
              SafeArea(
                child: Row(children: [
                  isLoading
                      ? loading
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("BDT ${profile.balance.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text("active balance".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.6))),
                            ],
                          ),
                        ),
                  ElevatedButton(
                    child: Text(' + Add Money',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      var c = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddMoneyScreen(
                                    profile: profile,
                                  )));
                      await getdata();
                      setState(() {});
                    },
                  ),
                  Spacer(),
                  ClipOval(
                    child: Material(
                      color: Colors
                          .transparent, //To let the Container background be displayed
                      child: IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors
                          .transparent, //To let the Container background be displayed
                      child: IconButton(
                          icon: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                DashBoardMainItemCard(
                  asset: "assets/svg/Sendmoney.svg",
                  title: "Groups",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SendMoneyScreen(
                                  profile: profile,
                                )));
                  },
                ),
                DashBoardMainItemCard(
                  asset: "assets/svg/Cashout.svg",
                  title: "Chats",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CashOutScreen()));
                  },
                ),
                DashBoardMainItemCard(
                  asset: "assets/svg/Recharge.svg",
                  title: "Savings",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MobileRechargeScreen()));
                  },
                ),
                DashBoardMainItemCard(
                  asset: "assets/svg/Scan.svg",
                  title: "Loans",
                  onTap: () {},
                ),
              ])
            ],
          ),
        ),
        SizedBox(),
        Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
            decoration: BoxDecoration(color: Color(0xFFEEF2F8)),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        "Payment Methods".toUpperCase(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87.withOpacity(0.8)),
                      ),
                      Spacer(),
                      ClipOval(
                        child: Material(
                          color: Colors
                              .transparent, //To let the Container background be displayed
                          child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.black87, size: 20),
                              onPressed: () {}),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillPayment(
                              type: 'ELEC',
                            ),
                          ),
                        );
                      },
                      child: PayBillsItem(
                          asset: "assets/img/mtn-1 1.png", title: "Mtn momo"),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BillPayment(
                                type: 'GAS',
                              ),
                            ),
                          );
                        },
                        child: PayBillsItem(
                            asset: "assets/img/Orange_logo 1.png",
                            title: "Orange money")),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BillPayment(
                              type: 'CARD',
                            ),
                          ),
                        );
                      },
                      child: PayBillsItem(
                          asset: "assets/img/credit-card.png",
                          title: "Credit Card"),
                    ),
                    //     GestureDetector(
                    //         onTap: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => BillPayment(
                    //                 type: 'WAT',
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //         child: PayBillsItem(
                    //             asset: "assets/img/water.png", title: "Water")),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => BillPayment(
                    //               type: 'EDU',
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //       child: PayBillsItem(
                    //           asset: "assets/img/education.png",
                    //           title: "Education"),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => BillPayment(
                    //               type: 'NET',
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //       child: PayBillsItem(
                    //           asset: "assets/img/internet.png", title: "Internet"),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => BillPayment(
                    //               type: 'TEL',
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //       child: PayBillsItem(
                    //           asset: "assets/img/telephone.png",
                    //           title: "Telephone"),
                    //     ),
                    //     GestureDetector(
                    //         onTap: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => BillPayment(
                    //                 type: 'TV',
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //         child: PayBillsItem(
                    //             asset: "assets/img/tv.png", title: "TV"))
                  ],
                )
              ],
            )),
        SizedBox(height: 10),
        ExpenseWidget()
      ]),
      bottomNavigationBar: Container(
        color: Colors.teal, // Set the background color to teal
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Groups',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff34baba),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Admin",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Image.asset(
                  "assets/img/lover-removebg-preview 1.png",
                  width: 92,
                  height: 96,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text("My Events"),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Calendar"),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text("My Groups"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text("Invite your friend"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Sign Out"),
          ),
          ListTile(
            leading: Icon(Icons.policy),
            title: Text("Privacy Policy"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.group_add),
            title: Text("Create a new group"),
          ),
          ListTile(
            leading: Icon(Icons.analytics),
            title: Text("Dashboard and Statistics"),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Your Account"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Profile Setting"),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text("My Location"),
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text("Admin Privileges"),
          ),
          ListTile(
            leading: Icon(Icons.emergency),
            title: Text("Emergency Contacts"),
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text("Saving Accounts"),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text("Terms and Conditions"),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Get Help"),
          ),
        ],
      ),
    );
  }
}
