import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/HexColorCode/HexColor.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _BottomNavigationDemoState createState() => _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   title: Row(
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(30), // Border radius for rounded corners
      //           border: Border.all(
      //             color: Colors.grey, // Border color
      //             width: 2, // Border width
      //           ),
      //         ),
      //         width: 30.sp, // Container width
      //         height: 30.sp, // Container height
      //         alignment: Alignment.center, // Align child widget to center
      //         child: Image.asset(
      //           "assets/menu.png", // Path to your image asset
      //           width: 17.sp, // Image width
      //           height: 17.sp, // Image height
      //         ),
      //       ),
      //
      //       Padding(
      //         padding: const EdgeInsets.only(left: 10.0),
      //         child: SizedBox(
      //           width: 30.sp,
      //           height: 30.sp,
      //           child: GestureDetector(
      //             onTap: () {
      //
      //             },
      //             child: Container(
      //                 child: ClipRRect(
      //                     borderRadius: BorderRadius.circular(30),
      //                     child: Image.network(
      //                       'photoUrl',
      //                       fit: BoxFit.cover,
      //                       width: 30.sp,
      //                       height: 30.sp,
      //                       errorBuilder: (context, object, stackTrace) {
      //                         return  ClipRRect(
      //                           borderRadius: BorderRadius.circular(30), // Half of width/height for perfect circle
      //                           child: Image.asset(
      //                             "assets/images/icons/profile.png",
      //                             fit: BoxFit.cover,
      //                             width: 30.sp,
      //                             height: 30.sp,
      //                           ),
      //                         );
      //                       },
      //                     )
      //                 )
      //             ),
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding:  EdgeInsets.only(top: 0.0,left: 10.sp),
      //         child:  Text.rich(TextSpan(
      //           text: 'James Charley',
      //           style: GoogleFonts.poppins(
      //             textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.grey),
      //           ),
      //         )),
      //
      //
      //
      //
      //       ),
      //
      //       Spacer(),
      //       Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(30), // Border radius for rounded corners
      //           border: Border.all(
      //             color: Colors.grey, // Border color
      //             width: 2, // Border width
      //           ),
      //         ),
      //         width: 30.sp, // Container width
      //         height: 30.sp, // Container height
      //         alignment: Alignment.center, // Align child widget to center
      //         child: Image.asset(
      //           "assets/notification.png", // Path to your image asset
      //           width: 20.sp, // Image width
      //           height: 20.sp, // Image height
      //         ),
      //       ),
      //
      //
      //     ],
      //   ),
      //   actions: <Widget>[
      //
      //
      //   ],
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,

                  height: 50.sp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(


                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.search, color: Colors.black),
                            ),
                            textInputAction: TextInputAction.next, // This sets the keyboard action to "Next"
                            onEditingComplete: () => FocusScope.of(context).nextFocus(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 150.sp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners with radius 10
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/customImages/bannerImg.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0), // Match the parent container's rounded corners
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Real Estate Solutions",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            Text(
                              "We are here to \n providing best deal \n on properties.",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 20.sp),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),


        ],
      ),
    );
  }
}
