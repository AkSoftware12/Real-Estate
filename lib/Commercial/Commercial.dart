import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/All%20Property/all_property.dart';
import 'package:realestate/AllCommercialProperty/all_commercial_property.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Model/property_type.dart';
import 'package:realestate/Property%20Deatils/property_deatils.dart';
import 'package:realestate/Utils/textSize.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/baseurl/baseurl.dart';

class CommercialScreen extends StatefulWidget {

  CommercialScreen({super.key});

  @override
  State<CommercialScreen> createState() => _CommercialScreenState();
}

class _CommercialScreenState extends State<CommercialScreen> {
  var _dotPosition=0;
  List<dynamic> banner = [];

  bool isLoading = true;
  List<dynamic> subcategory = [];
  List<PropertyTypeModel> property = [
    PropertyTypeModel(
        imageUrl: 'assets/customImages/workplace.png', text: 'Office Space'),
    PropertyTypeModel(imageUrl: 'assets/customImages/co-working.png',
        text: 'Co-Working Space'),
    PropertyTypeModel(
        imageUrl: 'assets/customImages/shop.png', text: 'Shop / Showroom'),
    PropertyTypeModel(
        imageUrl: 'assets/customImages/package.png', text: 'Other Commercial'),
  ];
  List<dynamic> allProperty = [];


  Future<void> allPropertyapi() async {
    final response = await http.get(Uri.parse(getAllCommercialProperties));
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



  @override
  void initState() {
    super.initState();
    CommercialCategory();
    allPropertyapi();
    hitBanner();
  }

  Future<void> hitBanner() async {
    final response = await http.get(Uri.parse(commercialBanner));
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


  Future<void> CommercialCategory() async {
    final response = await http.get(Uri.parse('${category}${'1'}'));
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


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: double.infinity, // Take full width of the screen
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(0.sp),
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

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      'Property Type',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 230.sp,
                  child: GridView.builder(
                    itemCount: subcategory.length,
                    physics: NeverScrollableScrollPhysics(),

                    // Example count, replace with your actual count
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.5, // Ratio of item height to width
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AllCommercialProperty()),);

                        },
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade50,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              SizedBox(
                                  height: 50.sp,
                                  width: 50.sp,
                                  child: Image.asset(
                                    property[index].imageUrl, fit: BoxFit.fill,)),
                              SizedBox(height: 8.0),
                              Text(
                                subcategory[index]['name'],
                                // Replace this with your text
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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
                      'Commercial Property',
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AllCommercialProperty()),);

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
                  height: 320,
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    // Disable scrolling
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,

                    children: List.generate(
                      4,
                          (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage(id: '',)),);

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
                                        "Dehradun",
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
                                      Text(
                                        '${"₹ 5000"}${" - "}${"₹ 1000"}',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(height: 10.sp),
                                      Text(
                                        '${"30+"}${"Flats For Sale"}',
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