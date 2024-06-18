import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/All%20Property/all_property.dart';
import 'package:realestate/ApiModel/ResidentialPropertyModel/residential_property_model.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Property%20Deatils/property_deatils.dart';
import 'package:realestate/PropertyLocality/property_locality.dart';
import 'package:realestate/ResidentialAllProperty/residential_all_property.dart';
import 'package:realestate/Utils/textSize.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/baseurl/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ResidentialScreen extends StatefulWidget {
  final String lat;
  final String lag;


  ResidentialScreen({super.key, required this.lat, required this.lag});

  @override
  State<ResidentialScreen> createState() => _ResidentialScreenState();
}

class _ResidentialScreenState extends State<ResidentialScreen> {
  int _dotPosition = 0;


  bool isLoading = true;
  List<dynamic> allProperty = [];
  List<dynamic> nearByProperty = [];
  List<dynamic> topLocality = [];
  List<dynamic> subcategory = [];
  List<dynamic> banner = [];



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
  void _refresh() {
    setState(() {
      nearByPropertyapi();

    });
  }

  @override
  void initState() {
    super.initState();
    allPropertyapi();
    ResidentialCategory();
    hitBanner();
    topLocalityApi();
    nearByPropertyapi();
    print(widget.lat);
    print(widget.lag);

  }
  Future<void> topLocalityApi() async {
    final response = await http.get(Uri.parse(allLocality));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['locality'];
      setState(() {
        topLocality = data;
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> hitBanner() async {
    final response = await http.get(Uri.parse(residentialBanner));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData.containsKey('data')) {
        setState(() {
          // Assuming 'data' is a list, update apiData accordingly
          banner = responseData['data'];
          // restBanner=responseData['data']['banner_img'];
          print(banner);

          // await saveDataLocally(responseData['posts']);
        });
      } else {
        throw Exception('Invalid API response: Missing "data" key');
      }
    }
  }

  Future<void> allPropertyapi() async {
    final response = await http.get(Uri.parse(getAllResidentialProperties));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['property'];
      setState(() {
        allProperty = data;
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> ResidentialCategory() async {
    final response = await http.get(Uri.parse('${category}${'2'}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['subcategory'];
      setState(() {
        subcategory = data;
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> nearByPropertyapi() async {



    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse(nearBy),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'latitude': widget.lat,
        'longitude': widget.lag,

      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey('properties')) {
        setState(() {
          // Assuming 'properties' is a list, update allProperty accordingly
          nearByProperty = responseData['properties'];
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

    int dotsCount = nearByProperty.isEmpty ? 1 : nearByProperty.length;

    // Ensure _dotPosition is within the valid range
    if (_dotPosition >= dotsCount) {
      _dotPosition = dotsCount - 1;
    }
    return   SingleChildScrollView(
      child: Container(
          width: double.infinity, // Take full width of the screen
          child:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(15.sp),
                      child: Container(
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
                    ),
                    SizedBox(
                      height: 0,
                    ),

                    Column(
                        children: [
                          GestureDetector(
                            onTap: (){



                            },
                            child: AspectRatio(
                              aspectRatio: 2.5,
                              child: CarouselSlider(items:banner.map((item) =>
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                        vertical: 10),
                                    child: Material(
                                      elevation: 5,
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                      clipBehavior: Clip.hardEdge,
                                      child: Container(
                                        height:  150.sp,
                                        width:
                                        MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.99,


                                        padding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(
                                              5.0),
                                        ),
                                        child: GestureDetector(
                                          onTap: (){

                                          },
                                          child: Image.network(
                                            item['picture_urls'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                //     Container(
                                //   decoration: BoxDecoration(
                                //       borderRadius:
                                //       BorderRadius.circular(
                                //           20.0),
                                //       image: DecorationImage(image: NetworkImage( imageBaseUrl +
                                //           item['banner_img']),fit:BoxFit.fitWidth)
                                //   ),
                                // )
                              ).toList(),options: CarouselOptions(
                                  height:  150.sp,
                                  aspectRatio: 2/1,
                                  viewportFraction: 0.95,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: false,
                                  enlargeFactor: 0.3,
                                  onPageChanged: (val,carouselPageChangedReason) {
                                    setState(() {
                                      _dotPosition = val;
                                    },);
                                  }

                              )),
                            ),
                          ),
                          const SizedBox(height: 1),
                          DotsIndicator(
                            dotsCount: banner.isEmpty?1:banner.length,
                            position: _dotPosition,
                            decorator: const DotsDecorator(
                              activeColor: Colors.orange,
                              color: Colors.blueGrey,
                              spacing: EdgeInsets.all(2),
                              activeSize: Size(8, 8),
                              size: Size(6, 6),
                            ),
                          ),
                        ]


                    ),

                    // Padding(
                    //   padding:  EdgeInsets.all(15.sp),
                    //   child: Container(
                    //     width: double.infinity,
                    //     height: 150.sp,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10.0),
                    //       // Rounded corners with radius 10
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.grey.withOpacity(0.5),
                    //           spreadRadius: 2,
                    //           blurRadius: 7,
                    //           offset: Offset(0, 3),
                    //         ),
                    //       ],
                    //     ),
                    //     child: Stack(
                    //       children: [
                    //         Container(
                    //           decoration: BoxDecoration(
                    //             image: DecorationImage(
                    //               image: AssetImage(
                    //                   "assets/customImages/bannerImg.png"),
                    //               fit: BoxFit.cover,
                    //             ),
                    //             borderRadius: BorderRadius.circular(
                    //                 10.0), // Match the parent container's rounded corners
                    //           ),
                    //         ),
                    //         Container(
                    //           padding: EdgeInsets.all(16.sp),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text(
                    //                 "Real Estate Solutions",
                    //                 style: GoogleFonts.poppins(
                    //                   textStyle: TextStyle(
                    //                       fontSize: 15.sp,
                    //                       fontWeight: FontWeight.bold,
                    //                       color: Colors.white),
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 height: 15.sp,
                    //               ),
                    //               Text(
                    //                 "We are here to \n providing best deal \n on properties.",
                    //                 style: GoogleFonts.poppins(
                    //                   textStyle: TextStyle(
                    //                       fontSize: 12.sp,
                    //                       fontWeight: FontWeight.normal,
                    //                       color: Colors.white),
                    //                 ),
                    //               ),
                    //               SizedBox(height: 20.sp),
                    //             ],
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.sp,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subcategory.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApartmentListing(backButton: 'back')),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(

                            // margin: EdgeInsets.all(12.sp),
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: HexColor('#f6f6f7'),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Center(
                              child: Padding(
                                padding:  EdgeInsets.only(left: 8.sp,right: 8.sp),
                                child: Text(
                                  subcategory[index]['name'],
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
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage(id: '',)),);

                      },
                      child: Text(
                        'View all',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: HexColor('#9ba3aa'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 430,
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    // Disable scrolling
                    crossAxisCount: 2,
                    children: List.generate(
                      4,
                          (index) => GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage(id: '',)),);

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: HexColor('#f6f6f7'),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(
                                    height: 90.sp,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        "assets/customImages/testFlatImg.jpg",
                                        height: 90.sp,
                                        fit: BoxFit.fill,
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Renovated Luxury Apartme'.length > 22
                                            ? 'Renovated Luxury Apartme'
                                            .substring(0, 22) +
                                            '...'
                                            : 'Renovated Luxury Apartme',
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
                                            size: 11.sp,
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '2021 San Pedro, Los Angeles 90'.length >
                                            25
                                            ? '2021 San Pedro, Los Angeles 90'
                                            .substring(0, 25) +
                                            '...'
                                            : '2021 San Pedro, Los Angeles 90',
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
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
              ),

              // All Property

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      'Residential Property',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ResidentialAllProperty()),);

                      },
                      child: Text(
                        'View all',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: HexColor('#9ba3aa'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               SizedBox(
          height: 430,
          child: GridView.count(
            physics: NeverScrollableScrollPhysics(), // Disable scrolling
            crossAxisCount: 2,
            children: List.generate(
              allProperty.length, // Use the length of allProperty
                  (index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyDeatilsPage(id: allProperty[index]['id'].toString()),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor('#f6f6f7'),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 90.sp,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              height: 90.sp,
                              imageUrl:  allProperty[index]['picture_urls'][0].toString(),
                              fit: BoxFit.cover, // Adjust this according to your requirement
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/no_image.jpg', // Path to your default image asset
                                height: 90.sp, // Adjust width as per your requirement
                                fit: BoxFit.cover, // Adjust this according to your requirement
                              ),
                            ),




                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [
                              Text(
                                '${allProperty[index]['property_name'].toString()}'.length > 22
                                    ? '${allProperty[index]['property_name'].toString()}'.substring(0, 22) + '...'
                                    : '${allProperty[index]['property_name'].toString()}',
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
                              Icon(
                                Icons.location_on,
                                size: 11.sp,
                                color: Colors.red,
                              ),
                              Text(
                                '2021 San Pedro, Los Angeles 90'.length > 25
                                    ? '2021 San Pedro, Los Angeles 90'.substring(0, 25) + '...'
                                    : '2021 San Pedro, Los Angeles 90',
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
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
              // All Property


              if(nearByProperty.isNotEmpty)
              Container(
                color: Colors.white,
                child:  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Text(
                              'Near By Properties',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ApartmentListing(backButton: 'back',)),);

                              },
                              child: Text(
                                'View all',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    color: HexColor('#9ba3aa'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: (){

                        },
                        child: AspectRatio(
                          aspectRatio: .96,
                          child: CarouselSlider(items:nearByProperty.map((item) =>
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 10),
                                child: Material(
                                  elevation: 5,
                                  borderRadius:
                                  BorderRadius.circular(
                                      8.0),
                                  clipBehavior: Clip.hardEdge,
                                  child: Container(
                                    height: double.infinity,
                                    width:
                                    MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.99,

                                    // padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(
                                          5.0),
                                    ),
                                    child:GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PropertyDeatilsPage(id: item['id'].toString()),
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
                                                        child:CachedNetworkImage(
                                                          height: 160.sp,
                                                          imageUrl: item['picture_urls'][0],
                                                          // imageUrl:  nearByProperty[0]['picture_urls'][0].toString(),
                                                          fit: BoxFit.cover, // Adjust this according to your requirement
                                                          placeholder: (context, url) => const Center(
                                                            child: CircularProgressIndicator(
                                                              color: Colors.orangeAccent,
                                                            ),
                                                          ),
                                                          errorWidget: (context, url, error) => Image.asset(
                                                            'assets/no_image.jpg', // Path to your default image asset
                                                            height: 90.sp, // Adjust width as per your requirement
                                                            fit: BoxFit.cover, // Adjust this according to your requirement
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
                                                      '${item['property_name'].toString()}',
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
                                                      '${item['property_address'].toString()}',
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
                                                      '${item['property_price'].toString()}',
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
                                                            _launchURL("tel://${item['owner_contact'].toString()}");
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
                                                            'https://www.google.com/maps/search/?api=1&query=${item['property_lat'].toString()},${item['property_long'].toString()}');
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
                                                                  'https://www.google.com/maps/search/?api=1&query=${item['property_lat'].toString()},${item['property_long'].toString()}');
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
                                    ),
                                  ),
                                ),
                              )
                            //     Container(
                            //   decoration: BoxDecoration(
                            //       borderRadius:
                            //       BorderRadius.circular(
                            //           20.0),
                            //       image: DecorationImage(image: NetworkImage( imageBaseUrl +
                            //           item['banner_img']),fit:BoxFit.fitWidth)
                            //   ),
                            // )
                          ).toList(),options: CarouselOptions(
                              height:double.infinity,
                              aspectRatio: 2/1,
                              viewportFraction: 0.99,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              enlargeFactor: 0.3,
                              onPageChanged: (val,carouselPageChangedReason) {
                                setState(() {
                                },);
                              }

                          )),
                        ),
                      ),
                    ]


                ),
              ),


              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      'Top Flats',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage(id: '',)),);

                      },
                      child: Text(
                        'View all',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: HexColor('#9ba3aa'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 360.sp,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4, // Set the number of items
                  itemBuilder: (BuildContext context, int index) {
                    // Here you can build your list item based on the index
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage(id: '',)),);

                      },
                      child: Container(
                        height: 75.sp,
                        decoration: BoxDecoration(
                          color: HexColor('#f6f6f7'),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        margin: EdgeInsets.only(left: 5.sp,top: 5.sp,bottom: 5.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: double.infinity,
                                width: 75.sp,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                margin: EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image(
                                    image: AssetImage(
                                        'assets/customImages/testFlatImg.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Padding(
                              padding:  EdgeInsets.all(8.sp),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: 0.sp,),
                                    child: Padding(
                                      padding:  EdgeInsets.only(top: 0.sp),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Renovated Luxury Apartme',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.radioCanada(
                                              textStyle: TextStyle(
                                                  fontSize: TextSizes.textsmall,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(height: 5.sp,),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 11.sp,
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                '2021 San Pedro, Los Angeles 90'.length >
                                                    20
                                                    ? '2021 San Pedro, Los Angeles 90'
                                                    .substring(0, 20) +
                                                    '...'
                                                    : '2021 San Pedro, Los Angeles 90',
                                                maxLines: 1,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.normal,
                                                    color: HexColor('#9ba3aa'),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                '₹ ',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: TextSizes.textsmall,
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
                                                      fontSize: TextSizes.textsmall,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                ' Per Month',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Container(),
                            Container(),
                            Container(),
                            Container(
                              height: 90.sp,
                              width: 60.sp,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  Container(
                                    height: 20.sp,
                                    width: 50.sp,
                                    decoration: BoxDecoration(
                                      color: HexColor('#122636'),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '1 BHK',
                                        style: GoogleFonts.cabinCondensed(
                                          textStyle: TextStyle(
                                              fontSize: TextSizes.textsmall,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.sp,)


                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 180.sp,
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
                                    "assets/customImages/banne2Img.jpg"),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    color: HexColor('#122636')
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Best Selling",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.sp,
                                ),
                                Text(
                                  "Best dealers in real estate, flats,\n appartments in your budget",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ApartmentListing(backButton: 'back')),);

                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "View More",
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: TextSizes.textsmall2,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.arrow_forward,size: 20.sp,color: Colors.white,),
                                      )
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
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      'Top Localities',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ApartmentListing(backButton: 'back')),);

                      },
                      child: Text(
                        'View all',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: HexColor('#9ba3aa'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 280,
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    // Disable scrolling
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                    children: List.generate(
                      topLocality.length,
                          (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LocalityProperty(localityCity: topLocality[index]['property_district'],)),);

                          },
                          child: Container(
                            width: double.infinity,
                            height: 100.sp,
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
                                          "assets/customImages/localitiesImg.jpg"),
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
                                        '${topLocality[index]['property_district']}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      // Text(
                                      //   '${"₹ 5000"}${" - "}${"₹ 1000"}',
                                      //   style: GoogleFonts.poppins(
                                      //     textStyle: TextStyle(
                                      //         fontSize: 12.sp,
                                      //         fontWeight: FontWeight.normal,
                                      //         color: Colors.white),
                                      //   ),
                                      // ),
                                      SizedBox(height: 10.sp),
                                      Text(
                                        '${"${topLocality[index]['property_count']}"} ${' '} ${"Flats For Sale"}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          )
      ),
    );

  }
}