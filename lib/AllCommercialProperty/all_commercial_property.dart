import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Property%20Deatils/property_deatils.dart';
import 'package:realestate/Utils/textSize.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:io';

import 'package:url_launcher/url_launcher_string.dart';

class AllCommercialProperty extends StatefulWidget {
  // final String backButton;


  const AllCommercialProperty({super.key, });

  @override
  State<AllCommercialProperty> createState() => AllCommercialPropertyState();
}

class AllCommercialPropertyState extends State<AllCommercialProperty> {
  _getDirection(url) async {
    try {
      launch(url);
    } catch (error, stack) {
      // log error
    }
  }

  _launchURL(url) async {
    try {
      launch(url);
    } catch (error, stack) {
      // log error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.sp),
                child: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'All Property ',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
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
                          prefixIcon: Icon(Icons.search, color: Colors.black),
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
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PropertyDeatilsPage(id: '',)),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: HexColor('#f6f6f7'),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      margin: EdgeInsets.all(2.0),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Container(
                              height: 160.sp,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    height: 160.sp,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/customImages/testFlatImg.jpg",
                                        height: 160.sp,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Renovated Luxury Apartme',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 13.sp,
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '2021 San Pedro, Los Angeles 90',
                                    maxLines: 1,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.normal,
                                        color: HexColor('#9ba3aa'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                    ),
                                  ),
                                  Text(
                                    '5000',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 15.sp,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        '4.5',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.sp),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 40.sp,
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius:
                                        BorderRadius.circular(10.sp),
                                        // Border radius for rounded corners
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/bed_solid.svg',
                                              width: 15.sp,
                                              height: 12.sp,
                                            ),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            Center(
                                              child: Text(
                                                ' Furnished',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize:
                                                      TextSizes.textsmall,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container(
                                      height: 40.sp,
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius:
                                        BorderRadius.circular(10.sp),
                                        // Border radius for rounded corners
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/car_solid.svg',
                                              width: 15.sp,
                                              height: 12.sp,
                                            ),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            Center(
                                              child: Text(
                                                ' Car Parking',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize:
                                                      TextSizes.textsmall,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.sp,
                                  ),
                                  GestureDetector(
                                    onTap:(){

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        borderRadius:
                                        BorderRadius.circular(10.sp),
                                        // Border radius for rounded corners
                                      ),
                                      height: 40.sp,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/people_group_solid.svg',
                                              width: 15.sp,
                                              height: 12.sp,
                                            ),
                                            SizedBox(
                                              width: 5.sp,
                                            ),
                                            Center(
                                              child: Text(
                                                ' For Family',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize:
                                                      TextSizes.textsmall,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.only(top: 15.sp, bottom: 15.sp),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.black,

                                      borderRadius:
                                      BorderRadius.circular(10.sp),
                                      // Border radius for rounded corners
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          _launchURL("tel://${6397199758}");
                                        },
                                        child: Row(
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 25.sp, right: 25.sp),
                                                child: Text(
                                                  ' Contact Agent',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        fontSize: TextSizes
                                                            .textsmall2,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _getDirection(
                                          'https://www.google.com/maps/search/?api=1&query=${30.3303616},${78.0081215}');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HexColor('#122636'),

                                        borderRadius:
                                        BorderRadius.circular(10.sp),
                                        // Border radius for rounded corners
                                      ),
                                      height: 40.sp,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            _getDirection(
                                                'https://www.google.com/maps/search/?api=1&query=${30.3303616},${78.0081215}');
                                          },
                                          child: Row(
                                            children: [
                                              Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.sp,
                                                      right: 25.sp),
                                                  child: Text(
                                                    'View Location',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          fontSize: TextSizes
                                                              .textsmall2,
                                                          fontWeight:
                                                          FontWeight.normal,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                // Disable scrolling
              ),
            )
          ],
        ),
      ),
    );
  }
}
