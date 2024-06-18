import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Property%20Deatils/property_deatils.dart';
import 'package:realestate/Utils/textSize.dart';
import 'package:realestate/baseurl/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher_string.dart';

class SearchProperty extends StatefulWidget {
  final String category_id;
  final String sub_category_id;
  final String min_price;
  final String max_price;
  final String address;
  final String buyRentStatus;

  const SearchProperty(
      {super.key,
      required this.category_id,
      required this.sub_category_id,
      required this.min_price,
      required this.max_price,
      required this.address,
      required this.buyRentStatus});

  @override
  State<SearchProperty> createState() => _ApartmentListingState();
}

class _ApartmentListingState extends State<SearchProperty> {
  bool isLoading = true;
  List<dynamic> allProperty = [];

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
  void initState() {
    super.initState();
    searchPropertyapi();
    print(widget.buyRentStatus);
    print(widget.category_id);
    print(widget.sub_category_id);
    print(widget.address);
    print(widget.min_price);
    print(widget.max_price);
  }

  Future<void> searchPropertyapi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse(searchForm),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'category_id': widget.category_id,
        'sub_category_id': widget.sub_category_id,
        'min_price': widget.min_price,
        'max_price': widget.max_price,
        'address': widget.address,
        'buyRentStatus': widget.buyRentStatus,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey('properties')) {
        setState(() {
          // Assuming 'properties' is a list, update allProperty accordingly
          allProperty = responseData['properties'];
          print(allProperty);
        });
      } else {
        // Print the entire response for debugging
        print('Invalid API response: Missing "properties" key');
        print(responseData);
        throw Exception('Invalid API response: Missing "properties" key');
      }
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
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
                  '${'Search Property' }',
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
                itemCount: allProperty.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyDeatilsPage(
                              id: allProperty[index]['id'].toString()),
                        ),
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
                                      child: CachedNetworkImage(
                                        height: 160.sp,
                                        imageUrl: allProperty[index]
                                                ['picture_urls'][0]
                                            .toString(),
                                        fit: BoxFit.cover,
                                        // Adjust this according to your requirement
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.orangeAccent,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/no_image.jpg',
                                          // Path to your default image asset
                                          height: 90.sp,
                                          // Adjust width as per your requirement
                                          fit: BoxFit
                                              .cover, // Adjust this according to your requirement
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    '${allProperty[index]['property_name'].toString()}',
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
                                    '${allProperty[index]['property_address'].toString()}',
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
                                    '${allProperty[index]['property_price'].toString()}',
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
                                    onTap: () {},
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
                                          _launchURL(
                                              "tel://${allProperty[index]['owner_contact'].toString()}");
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
                                          'https://www.google.com/maps/search/?api=1&query=${allProperty[index]['property_lat'].toString()},${allProperty[index]['property_long'].toString()}');
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
                                                'https://www.google.com/maps/search/?api=1&query=${allProperty[index]['property_lat'].toString()},${allProperty[index]['property_long'].toString()}');
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
