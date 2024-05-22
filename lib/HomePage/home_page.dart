import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/Account/account.dart';
import 'package:realestate/All%20Property/all_property.dart';
import 'package:realestate/HomePage/home_page.dart';
import 'package:realestate/HomeScreen/home_screen.dart';
import 'package:realestate/Location/location.dart';
import 'package:realestate/Search/search.dart';
import 'package:realestate/Utils/color.dart';
import 'package:realestate/Utils/string.dart';
import 'package:realestate/Utils/textSize.dart';







class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}
class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ApartmentListing(backButton: '',),
    SearchScreen(),
    CityGrid(),
    AccountPage(),
  ];

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isExpanded = false;
  bool _isExpandedRent  = false;
  bool _isExpandedNewProject  = false;
  bool _isExpandedLocation  = false;
  bool _isExpandedAccount = false;
  final List<String> items = ['1 Bhk', '2 Bhk', '3 Bhk', '4 Bhk', '5 Bhk'];
  final List<String> project = ['Flats', 'Houses', 'Villas',];
  final List<String> location = ['Dehradun', 'Chandigarh', 'Delhi','Mumbai'];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // Border radius for rounded corners
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 2, // Border width
                  ),
                ),
                width: 30.sp,
                // Container width
                height: 30.sp,
                // Container height
                alignment: Alignment.center,
                // Align child widget to center
                child: Image.asset(
                  "assets/menu.png", // Path to your image asset
                  width: 17.sp, // Image width
                  height: 17.sp, // Image height
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 30.sp,
                height: 30.sp,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            'photoUrl',
                            fit: BoxFit.cover,
                            width: 30.sp,
                            height: 30.sp,
                            errorBuilder: (context, object, stackTrace) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                // Half of width/height for perfect circle
                                child: Image.asset(
                                  "assets/images/icons/profile.png",
                                  fit: BoxFit.cover,
                                  width: 30.sp,
                                  height: 30.sp,
                                ),
                              );
                            },
                          ))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.0, left: 10.sp),
              child: Text.rich(TextSpan(
                text: 'James Charley',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
              )),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                // Border radius for rounded corners
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 2, // Border width
                ),
              ),
              width: 30.sp,
              // Container width
              height: 30.sp,
              // Container height
              alignment: Alignment.center,
              // Align child widget to center
              child: Image.asset(
                "assets/notification.png", // Path to your image asset
                width: 20.sp, // Image width
                height: 20.sp, // Image height
              ),
            ),
          ],
        ),
        actions: <Widget>[],
      ),


      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: const Color(0xFF222B40),
                child: Padding(
                  padding: EdgeInsets.only(top: 50.sp, bottom: 20.sp),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30, // Adjust the radius as needed
                      backgroundImage: AssetImage(
                          'assets/images/icons/profile.png'), // Provide your image path
                    ),
                    title: Text(
                      "Hi, James Charley!",
                      style: GoogleFonts.radioCanada(
                        // Replace with your desired Google Font
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: TextSizes.textmedium,
                          // Adjust font size as needed
                          fontWeight: FontWeight
                              .normal, // Adjust font weight as needed
                          // Adjust font color as needed
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the drawer
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                      // );
                    },
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[

                    Divider(
                      color: Colors.grey.shade300,
                      // Set the color of the divider
                      thickness: 1.0,
                      // Set the thickness of the divider
                      height: 1, // Set the height of the divider
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.menu_outlined,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Home",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),



                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Login",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.account_circle,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "Profile ",
                                    style: GoogleFonts.radioCanada(
                                      // Replace with your desired Google Font
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: TextSizes.textmedium,
                                        // Adjust font size as needed
                                        fontWeight: FontWeight
                                            .normal, // Adjust font weight as needed
                                        // Adjust font color as needed
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );

                            //   ListTile(
                            //   leading: Icon(
                            //     Icons.account_circle,
                            //     color: Colors.black,
                            //   ),
                            //   title:Text(
                            //     " Profile ",
                            //     style: GoogleFonts.poppins(
                            //       // Replace with your desired Google Font
                            //       textStyle: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: TextSizes.textmedium,
                            //         // Adjust font size as needed
                            //         fontWeight: FontWeight
                            //             .normal, // Adjust font weight as needed
                            //         // Adjust font color as needed
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp),
                            child: Container(
                              height: 90.sp,
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,top: 15.sp,bottom: 10.sp),
                                          child: Text(
                                            "View Profile ",
                                            style: GoogleFonts.radioCanada(
                                              // Replace with your desired Google Font
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: TextSizes.textmedium,
                                                // Adjust font size as needed
                                                fontWeight: FontWeight
                                                    .normal, // Adjust font weight as needed
                                                // Adjust font color as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,bottom: 15.sp),
                                          child: Text(
                                            "Edit Profile ",
                                            style: GoogleFonts.radioCanada(
                                              // Replace with your desired Google Font
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: TextSizes.textmedium,
                                                // Adjust font size as needed
                                                fontWeight: FontWeight
                                                    .normal, // Adjust font weight as needed
                                                // Adjust font color as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),

                            ),
                          ),
                          isExpanded: _isExpanded,
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedRent = !_isExpandedRent;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.home,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "Properties For Rent  ",
                                    style: GoogleFonts.radioCanada(
                                      // Replace with your desired Google Font
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: TextSizes.textmedium,
                                        // Adjust font size as needed
                                        fontWeight: FontWeight
                                            .normal, // Adjust font weight as needed
                                        // Adjust font color as needed
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );

                            //   ListTile(
                            //   leading: Icon(
                            //     Icons.account_circle,
                            //     color: Colors.black,
                            //   ),
                            //   title:Text(
                            //     " Profile ",
                            //     style: GoogleFonts.poppins(
                            //       // Replace with your desired Google Font
                            //       textStyle: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: TextSizes.textmedium,
                            //         // Adjust font size as needed
                            //         fontWeight: FontWeight
                            //             .normal, // Adjust font weight as needed
                            //         // Adjust font color as needed
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp,),
                            child: Container(
                              height: 180.sp,
                              color: Colors.grey.shade200,
                              child:ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (BuildContext context,int index){
                                    return GestureDetector(
                                      onTap: (){

                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(bottom: 10.sp),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(items[index],
                                            style: GoogleFonts.radioCanada(
                                              // Replace with your desired Google Font
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: TextSizes.textmedium,
                                                // Adjust font size as needed
                                                fontWeight: FontWeight
                                                    .normal, // Adjust font weight as needed
                                                // Adjust font color as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  }),

                            ),
                          ),
                          isExpanded: _isExpandedRent,
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedNewProject = !_isExpandedNewProject;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.calendar_view_week_sharp,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "New projects ",
                                    style: GoogleFonts.radioCanada(
                                      // Replace with your desired Google Font
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: TextSizes.textmedium,
                                        // Adjust font size as needed
                                        fontWeight: FontWeight
                                            .normal, // Adjust font weight as needed
                                        // Adjust font color as needed
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );

                            //   ListTile(
                            //   leading: Icon(
                            //     Icons.account_circle,
                            //     color: Colors.black,
                            //   ),
                            //   title:Text(
                            //     " Profile ",
                            //     style: GoogleFonts.poppins(
                            //       // Replace with your desired Google Font
                            //       textStyle: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: TextSizes.textmedium,
                            //         // Adjust font size as needed
                            //         fontWeight: FontWeight
                            //             .normal, // Adjust font weight as needed
                            //         // Adjust font color as needed
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp,),
                            child: Container(
                              height: 150.sp,
                              color: Colors.grey.shade200,
                              child:ListView.builder(
                                  itemCount: project.length,
                                  itemBuilder: (BuildContext context,int index){
                                    return GestureDetector(
                                      onTap: (){

                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(bottom: 10.sp),
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,bottom: 10.sp),
                                          child: Text(project[index],
                                            style: GoogleFonts.radioCanada(
                                              // Replace with your desired Google Font
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: TextSizes.textmedium,
                                                // Adjust font size as needed
                                                fontWeight: FontWeight
                                                    .normal, // Adjust font weight as needed
                                                // Adjust font color as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                  }),

                            ),
                          ),
                          isExpanded: _isExpandedNewProject,
                        ),
                      ],
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedLocation = !_isExpandedLocation;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.location_on,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "Explore localities ",
                                    style: GoogleFonts.radioCanada(
                                      // Replace with your desired Google Font
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: TextSizes.textmedium,
                                        // Adjust font size as needed
                                        fontWeight: FontWeight
                                            .normal, // Adjust font weight as needed
                                        // Adjust font color as needed
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );

                            //   ListTile(
                            //   leading: Icon(
                            //     Icons.account_circle,
                            //     color: Colors.black,
                            //   ),
                            //   title:Text(
                            //     " Profile ",
                            //     style: GoogleFonts.poppins(
                            //       // Replace with your desired Google Font
                            //       textStyle: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: TextSizes.textmedium,
                            //         // Adjust font size as needed
                            //         fontWeight: FontWeight
                            //             .normal, // Adjust font weight as needed
                            //         // Adjust font color as needed
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp,),
                            child: Container(
                              height: 200.sp,
                              child:Container(
                                height: 150.sp,
                                color: Colors.grey.shade200,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: 3,
                                          itemBuilder: (BuildContext context,int index){
                                            return GestureDetector(
                                              onTap: (){

                                              },
                                              child: Padding(
                                                padding:  EdgeInsets.only(bottom: 10.sp),
                                                child: Padding(
                                                  padding:  EdgeInsets.only(left: 10.sp,bottom: 10.sp),
                                                  child: Text(location[index],
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: TextSizes.textmedium,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .normal, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );

                                          }),
                                    ),
                                  Container(
                                    width: double.infinity,
                                    height: 40.sp,
                                    color:  Color(0xFF222B40),
                                    child: Row(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 15.sp),
                                            child: GestureDetector(
                                              onTap: (){

                                              },
                                              child: Text(
                                                'Explore More +',
                                                style: GoogleFonts.radioCanada(
                                                  // Replace with your desired Google Font
                                                  textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: TextSizes.textmedium,
                                                    // Adjust font size as needed
                                                    fontWeight: FontWeight
                                                        .normal, // Adjust font weight as needed
                                                    // Adjust font color as needed
                                                  ),
                                                ),

                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                  ],
                                )


                              ),

                            ),
                          ),
                          isExpanded: _isExpandedLocation,
                        ),
                      ],
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.join_full_sharp,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Property Advise ",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.post_add,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Post Property ",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedAccount = !_isExpandedAccount;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.account_box,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "My Account ",
                                    style: GoogleFonts.radioCanada(
                                      // Replace with your desired Google Font
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: TextSizes.textmedium,
                                        // Adjust font size as needed
                                        fontWeight: FontWeight
                                            .normal, // Adjust font weight as needed
                                        // Adjust font color as needed
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );


                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp),
                            child: Container(
                              height: 90.sp,
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,top: 15.sp,bottom: 15.sp),
                                          child: Text(
                                            "Change Password ",
                                            style: GoogleFonts.radioCanada(
                                              // Replace with your desired Google Font
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: TextSizes.textmedium,
                                                // Adjust font size as needed
                                                fontWeight: FontWeight
                                                    .normal, // Adjust font weight as needed
                                                // Adjust font color as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){

                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,bottom: 15.sp),
                                          child: Text(
                                            "Forgot Password ",
                                            style: GoogleFonts.radioCanada(
                                              // Replace with your desired Google Font
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: TextSizes.textmedium,
                                                // Adjust font size as needed
                                                fontWeight: FontWeight
                                                    .normal, // Adjust font weight as needed
                                                // Adjust font color as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),

                            ),
                          ),
                          isExpanded: _isExpandedAccount,
                        ),
                      ],
                    ),


                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.feedback,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Feedback ",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.rate_review,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Rate Us ",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.reviews,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Review ",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Setting ",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.help,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Help ",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.privacy_tip,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Faq's ",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Logout ",
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),
                  ],
                ),
              )

              // Add more list items as needed
            ],
          ),
        ),
      ),
      body: Homepage._widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/home_inactive.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/home_active.png",
              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/list.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/list.png",
              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/search.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/search.png",
              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/location.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/location.png",
              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/user.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/user.png",
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
        selectedFontSize: 0,
        // Set font size to 0 for selected label
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
