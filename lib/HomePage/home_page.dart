import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/HomeScreen/home_screen.dart';
import 'package:realestate/Utils/color.dart';
import 'package:realestate/Utils/string.dart';



class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Page'),
    );
  }
}

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Location Page'),
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Account Page'),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Menu Page'),
    );
  }
}

class Homepage extends StatefulWidget {
   Homepage({Key? key}) : super(key: key);

  static  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    SearchPage(),
    LocationPage(),
    AccountPage(),
    MenuPage(),
  ];

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // Border radius for rounded corners
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 2, // Border width
                ),
              ),
              width: 30.sp, // Container width
              height: 30.sp, // Container height
              alignment: Alignment.center, // Align child widget to center
              child: Image.asset(
                "assets/menu.png", // Path to your image asset
                width: 17.sp, // Image width
                height: 17.sp, // Image height
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 30.sp,
                height: 30.sp,
                child: GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            'photoUrl',
                            fit: BoxFit.cover,
                            width: 30.sp,
                            height: 30.sp,
                            errorBuilder: (context, object, stackTrace) {
                              return  ClipRRect(
                                borderRadius: BorderRadius.circular(30), // Half of width/height for perfect circle
                                child: Image.asset(
                                  "assets/images/icons/profile.png",
                                  fit: BoxFit.cover,
                                  width: 30.sp,
                                  height: 30.sp,
                                ),
                              );
                            },
                          )
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 0.0,left: 10.sp),
              child:  Text.rich(TextSpan(
                text: 'James Charley',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.grey),
                ),
              )),




            ),

            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // Border radius for rounded corners
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 2, // Border width
                ),
              ),
              width: 30.sp, // Container width
              height: 30.sp, // Container height
              alignment: Alignment.center, // Align child widget to center
              child: Image.asset(
                "assets/notification.png", // Path to your image asset
                width: 20.sp, // Image width
                height: 20.sp, // Image height
              ),
            ),


          ],
        ),
        actions: <Widget>[


        ],
      ),
      body: Homepage._widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[

          const BottomNavigationBarItem(
            icon: ImageIcon( // Use ImageIcon instead of Image.asset
              AssetImage("assets/home_inactive.png"), // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon( // Active icon for selected state
              AssetImage("assets/home_active.png",

              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon( // Use ImageIcon instead of Image.asset
              AssetImage("assets/list.png"), // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon( // Active icon for selected state
              AssetImage("assets/list.png",

              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon( // Use ImageIcon instead of Image.asset
              AssetImage(   "assets/search.png"), // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon( // Active icon for selected state
              AssetImage(   "assets/search.png",

              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon( // Use ImageIcon instead of Image.asset
              AssetImage(     "assets/location.png"), // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon( // Active icon for selected state
              AssetImage(    "assets/location.png",

              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon( // Use ImageIcon instead of Image.asset
              AssetImage(     "assets/user.png"), // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon( // Active icon for selected state
              AssetImage(      "assets/user.png",

              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),

        ],


        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        selectedFontSize: 0, // Set font size to 0 for selected label
        unselectedFontSize: 0,

        // Set font size to 0 for unselected label
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Homepage(),
  ));
}
