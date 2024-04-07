import 'package:flutter/cupertino.dart';
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
  final List<String> items = ['1 Bhk', '2 Bhk', '3 Bhk', '4 Bhk', '5 Bhk'];

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Column(
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
                                  textStyle: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.black),
                                ),
                                textInputAction: TextInputAction.next,
                                // This sets the keyboard action to "Next"
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
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
                        borderRadius: BorderRadius.circular(10.0),
                        // Rounded corners with radius 10
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
                                image: AssetImage(
                                    "assets/customImages/bannerImg.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(
                                  10.0), // Match the parent container's rounded corners
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
                                    textStyle: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                Text(
                                  "We are here to \n providing best deal \n on properties.",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
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
              SizedBox(
                height: 50.sp,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 80,
                          // margin: EdgeInsets.all(12.sp),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: HexColor('#f6f6f7'),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text(
                              items[index],
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      'Recently Added',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'View all',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: HexColor('#9ba3aa'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 500,
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    // Disable scrolling
                    crossAxisCount: 2,
                    children: List.generate(
                      4,
                      (index) => Container(
                        decoration: BoxDecoration(
                          color: HexColor('#f6f6f7'),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        margin: EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 90.sp,
                                  child: Image.asset("assets/customImages/testFlatImg.jpg",fit: BoxFit.fill,)),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                                            children: [
                                    Text(

                                      'Renovated Luxury Apartme'.length > 22 ?  'Renovated Luxury Apartme'.substring(0, 22) + '...' :  'Renovated Luxury Apartme',


                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,size: 11.sp,color: Colors.red,),
                                      ],
                                    ),
                                    Text(
                                      '2021 San Pedro, Los Angeles 90'.length > 25 ?  '2021 San Pedro, Los Angeles 90'.substring(0, 25) + '...' :  '2021 San Pedro, Los Angeles 90',


                                      maxLines: 1,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.normal,
                                          color: HexColor('#9ba3aa'),
                                        ),
                                      ),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  children: [
                                    Text(

                                      '₹ ',


                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),),
                                    Text(

                                       '5000',


                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),),


                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ))
        ],
      ),
    );
  }
}
