import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/All%20Property/all_property.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Property%20Deatils/property_deatils.dart';
import 'package:realestate/Utils/textSize.dart';

class ResidentialScreen extends StatefulWidget {


  ResidentialScreen({super.key});

  @override
  State<ResidentialScreen> createState() => _ResidentialScreenState();
}

class _ResidentialScreenState extends State<ResidentialScreen> {
  final List<String> items = ['1 Bhk', '2 Bhk', '3 Bhk', '4 Bhk', '5 Bhk'];
  var _dotPosition=0;


  final List<String> _images = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoz_5HDm5Raa-Imfc-OnNf-KXwzA2Ox3Zcp0nbFoEFtzCaY5mVg_V3Xpxc2ovY5FsmLOs&usqp=CAU',
    'https://www.pngmart.com/files/15/Vector-Home-PNG-Photos.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDsWnStDcZz9gMZfigH_LesuQiplssDYUr5jYqV-f5DQ&s',
    'https://5.imimg.com/data5/JS/DP/IQ/IOS-69757314/product-jpeg-500x500.png',
  ];
  @override
  Widget build(BuildContext context) {
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
                      height: 10,
                    ),

                    Column(
                        children: [
                          GestureDetector(
                            onTap: (){



                            },
                            child: AspectRatio(
                              aspectRatio: 2.5,
                              child: CarouselSlider(items:_images.map((item) =>
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


                                        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
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
                                            item,
                                            fit: BoxFit.fill,
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
                            dotsCount: _images.isEmpty?1:_images.length,
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
                  itemCount: items.length,
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage()),);

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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage()),);

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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage()),);

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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage()),);

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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage()),);

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