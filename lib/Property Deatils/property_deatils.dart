import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/All%20Property/all_property.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Utils/textSize.dart';

class PropertyDeatilsPage extends StatefulWidget {
  const PropertyDeatilsPage({super.key});

  @override
  State<PropertyDeatilsPage> createState() => _PropertyDeatilsPageState();
}

class _PropertyDeatilsPageState extends State<PropertyDeatilsPage> {
  var _dotPosition=0;
  bool _isExpanded = true;
  bool _isExpanded2 = true;
  bool _isExpanded3 = true;
  bool _isExpanded34 = true;


  final List<String> _images = [
    'https://freepngimg.com/thumb/vegetable/9-2-vegetable-free-download-png.png',
    'https://i.pinimg.com/736x/9e/1f/5b/9e1f5b5a9d1d92191e410cc9a734ff50.jpg',
    'https://img.freepik.com/free-photo/green-broccoli-levitating-white-background_485709-79.jpg',
    'https://pngimg.com/uploads/cabbage/small/cabbage_PNG8803.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRe2DcljRuOkGIHmSRwTHL4lDNg8BiYtlz0KQ&usqp=CAU',
    'https://www.winedesign.com.au/wp-content/uploads/2016/05/DSC_0499.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST7LTLdC8SNtKl0mKZ2FpS71sijEXYfD_EcwUQfhnqBQe30khWPxHmKr4rDuwjS7TUqC4&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZbFBExP1N084WuUGJgRuwwTAY10cb0QOU9Q&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8449UAxHMQgrcbgUt_KuTDbNZbDyEG6xFkQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzwdyCPZkAPbl7UPwCxrGiQ28l1mPiXyQUQQ&usqp=CAU',
    'https://banner2.cleanpng.com/20180408/yte/kisspng-fast-food-restaurant-junk-food-kfc-hamburger-junk-food-5aca9ac191eb27.0987335415232273295977.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHBfARWpfkb5M-2zA0UY62Es3ozcDOD2fsarzzY66zNesJO-xhpSwgVb8k2d291vx9RBI&usqp=CAU',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#f6f6f7'),
        title: Text(
          'Property Deatils',
          style:GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: TextSizes.textmedium,
              fontWeight: FontWeight.bold
            )
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(bottom: 50.sp),
          child: Container(
            color: HexColor('#f6f6f7'),
            child: Container(
              color: HexColor('#f6f6f7'),
              child: Column(
                children: [
                  Container(
                    color: HexColor('#f6f6f7'),
                    child: Column(
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
                                        height: 165,
                                        width:
                                        MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.99,
                                        //                                            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
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
                                  height: 165.0,
                                  aspectRatio: 2/1,
                                  viewportFraction: 0.85,
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: HexColor('#f6f6f7'),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage()),);

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage()),);

                            },
                            child: SizedBox(
                              height: 35.sp,
                              child: Image.asset('assets/viewAllImg.png', fit: BoxFit.fill,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    height: 1.sp,
                    color: Colors.grey.shade200,

                  ),
                  Container(
                    color: HexColor('#f6f6f7'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage()),);

                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> PropertyDeatilsPage()),);

                            },
                            child: SizedBox(
                              height: 35.sp,
                              child: Container(
                                width: 100.sp,
                                height: 40.sp,

                                decoration: BoxDecoration(
                                  color: HexColor('#212529'),
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
                                child: Center(child: Text('1 Bhk',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white
                                    ),
                                  ),
                                )),
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 5.sp,
                              ),
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
                              Text(
                                ' |',
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
                                ' 1 BHK Flat',
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
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5.sp,
                              ),
                              Text(
                                'Posted on 25 May, 2023',
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
                          padding:  EdgeInsets.only(top: 18.sp),
                          child: ExpansionPanelList(
                            elevation: 0,
                            expansionCallback: (int index, bool isExpanded) {
                              setState(() {
                                _isExpanded = !_isExpanded;
                              });
                            },
                            children: [
                              ExpansionPanel(
                                backgroundColor: HexColor('#f6f6f7'),

                                headerBuilder: (BuildContext context, bool isExpanded) {
                                  return Row(
                                    children: [

                                      Padding(
                                        padding:  EdgeInsets.only(left: 0.sp),
                                        child: Text(
                                          "Overview",
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
                                body: Container(
                                  height: 220.sp,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                     Divider(
                                       height: 1.sp,
                                       color: Colors.grey.shade200,
                                     ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Padding(
                                                  padding:  EdgeInsets.only(top: 5.sp),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Super Built-Up Area',
                                                        style: GoogleFonts.radioCanada(
                                                          // Replace with your desired Google Font
                                                          textStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: TextSizes.textsmall2,
                                                            // Adjust font size as needed
                                                            fontWeight: FontWeight
                                                                .normal, // Adjust font weight as needed
                                                            // Adjust font color as needed
                                                          ),
                                                        ),),
                                                      SizedBox(height: 5.sp,),
                                                      Text(
                                                        "1950 sqft" ,
                                                        style: GoogleFonts.radioCanada(
                                                          // Replace with your desired Google Font
                                                          textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: TextSizes.textsmall2,
                                                            // Adjust font size as needed
                                                            fontWeight: FontWeight
                                                                .normal, // Adjust font weight as needed
                                                            // Adjust font color as needed
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Floor',
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),),
                                                    SizedBox(height: 5.sp,),
                                                    Text(
                                                      "8 (Out of 9 Floors)" ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Location',
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),),
                                                    SizedBox(height: 5.sp,),
                                                    Text(
                                                      "Rajpur Road, Dehradun" ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Facing',
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),),
                                                    SizedBox(height: 5.sp,),
                                                    Text(
                                                      "East" ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Spacer(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Padding(
                                                  padding:  EdgeInsets.only(top: 5.sp),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Security Amount',
                                                        style: GoogleFonts.radioCanada(
                                                          // Replace with your desired Google Font
                                                          textStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: TextSizes.textsmall2,
                                                            // Adjust font size as needed
                                                            fontWeight: FontWeight
                                                                .normal, // Adjust font weight as needed
                                                            // Adjust font color as needed
                                                          ),
                                                        ),),
                                                      SizedBox(height: 5.sp,),
                                                      Text(
                                                        "jdcu" ,
                                                        style: GoogleFonts.radioCanada(
                                                          // Replace with your desired Google Font
                                                          textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: TextSizes.textsmall2,
                                                            // Adjust font size as needed
                                                            fontWeight: FontWeight
                                                                .normal, // Adjust font weight as needed
                                                            // Adjust font color as needed
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Society',
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),),
                                                    SizedBox(height: 5.sp,),
                                                    Text(
                                                      "Lotus Enclave" ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Status',
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),),
                                                    SizedBox(height: 5.sp,),
                                                    Text(
                                                      "Immediately" ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Configuration',
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),),
                                                    SizedBox(height: 5.sp,),
                                                    Text(
                                                      "1 Bed, 1 Kitchen, 1 Bath" ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),

                                ),
                                isExpanded: _isExpanded,
                              ),
                            ],
                          ),
                        ),

                        ExpansionPanelList(
                          elevation: 0,
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              _isExpanded2 = !_isExpanded2;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              backgroundColor: HexColor('#f6f6f7'),
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return Row(
                                  children: [

                                    Padding(
                                      padding:  EdgeInsets.only(left: 0.sp),
                                      child: Text(
                                        "Property Details",
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
                              body: Container(
                                height: 170.sp,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Divider(
                                      height: 1.sp,
                                      color: Colors.grey.shade200,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding:  EdgeInsets.only(top: 5.sp),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Status :" ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .bold, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    "Floor :" ,
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .bold, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    "Furnishing :" ,
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .bold, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    "Facing :" ,
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .bold, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    "Landmark :" ,
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .bold, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding:  EdgeInsets.only(top: 5.sp),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Immediately Available',
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('5 of 9 Floor',
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .normal, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Full Furnished',
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .normal, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('East',
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .normal, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Trident Enclave',
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .normal, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),),

                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Spacer(),

                                      ],
                                    ),

                                  ],
                                ),

                              ),
                              isExpanded: _isExpanded2,
                            ),
                          ],
                        ),
                        ExpansionPanelList(
                          elevation: 0,
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              _isExpanded3 = !_isExpanded3;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              backgroundColor: HexColor('#f6f6f7'),

                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return Row(
                                  children: [

                                    Padding(
                                      padding:  EdgeInsets.only(left: 0.sp),
                                      child: Text(
                                        "Amenities",
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
                              body: Container(
                                height: 100.sp,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Divider(
                                      height: 1.sp,
                                      color: Colors.grey.shade200,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding:  EdgeInsets.only(top: 5.sp),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Water :" ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .bold, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    "Invertor :" ,
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .bold, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    "Security :" ,
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .bold, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Padding(
                                                padding:  EdgeInsets.only(top: 5.sp),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('24/7 Availability',
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Invertor Facility',
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .normal, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('24/7 Security',
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .normal, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),),

                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                        Spacer(),
                                        Spacer(),

                                      ],
                                    ),

                                  ],
                                ),

                              ),
                              isExpanded: _isExpanded3,
                            ),
                          ],
                        ),
                        ExpansionPanelList(
                          elevation: 0,
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              _isExpanded34= !_isExpanded34;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              backgroundColor: HexColor('#f6f6f7'),

                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return Row(
                                  children: [

                                    Padding(
                                      padding:  EdgeInsets.only(left: 0.sp),
                                      child: Text(
                                        "FAQ'S",
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
                              body: Container(
                                height: 150.sp,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Divider(
                                      height: 1.sp,
                                      color: Colors.grey.shade200,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.all(0.0),
                                              child:Padding(
                                                padding:  EdgeInsets.only(top: 5.sp,),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Q. Any restriction for visitors or guest?" ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "Ans. No Restrictions." ,
                                                      style: GoogleFonts.radioCanada(
                                                        // Replace with your desired Google Font
                                                        textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: TextSizes.textsmall2,
                                                          // Adjust font size as needed
                                                          fontWeight: FontWeight
                                                              .normal, // Adjust font weight as needed
                                                          // Adjust font color as needed
                                                        ),
                                                      ),
                                                    ),
                                                     Divider(
                                                      height: 5.sp,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    "Invertor :" ,
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .bold, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text(
                                                    "Security :" ,
                                                    style: GoogleFonts.radioCanada(
                                                      // Replace with your desired Google Font
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: TextSizes.textsmall2,
                                                        // Adjust font size as needed
                                                        fontWeight: FontWeight
                                                            .bold, // Adjust font weight as needed
                                                        // Adjust font color as needed
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),


                                      ],
                                    ),

                                  ],
                                ),

                              ),
                              isExpanded: _isExpanded34,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),



                  Container(
                    color: Colors.white,
                    child:  Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Text(
                                  'Similar Properties',
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
                                                children: [
                                                  Container(
                                                    height: 150.sp,
                                                    width: double.infinity,

                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(5.0),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: SizedBox(
                                                          height: 110.sp,
                                                          width: double.infinity,
                                                          child: Image.asset(
                                                            "assets/customImages/testFlatImg.jpg",
                                                            fit: BoxFit.fill,
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
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                            Icon(Icons.star, color: Colors.orange,size: 15.sp,),
                                                            SizedBox(width: 4),
                                                            Text('4.5',
                                                              style: TextStyle(color: Colors.black),),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding:  EdgeInsets.only(top: 8.sp),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: 40.sp,
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                  'assets/bed_solid.svg',
                                                                  width: 15.sp,
                                                                  height: 12.sp,
                                                                ),
                                                                SizedBox(width: 5.sp,),
                                                                Center(
                                                                  child: Text(' Furnished',
                                                                    style: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          fontSize: TextSizes.textsmall,
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Colors.black),
                                                                    ),),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.sp,
                                                        ),
                                                        Container(
                                                          height: 40.sp,
                                                          color: Colors.white,

                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                  'assets/car_solid.svg',
                                                                  width: 15.sp,
                                                                  height: 12.sp,
                                                                ),
                                                                SizedBox(width: 5.sp,),
                                                                Center(
                                                                  child: Text(' Car Parking',
                                                                    style: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          fontSize: TextSizes.textsmall,                                                fontWeight: FontWeight.normal,
                                                                          color: Colors.black),
                                                                    ),),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.sp,
                                                        ),
                                                        Container(
                                                          color: Colors.white,

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
                                                                SizedBox(width: 5.sp,),
                                                                Center(
                                                                  child: Text(' For Family',
                                                                    style: GoogleFonts.poppins(
                                                                      textStyle: TextStyle(
                                                                          fontSize: TextSizes.textsmall,                                                fontWeight: FontWeight.normal,
                                                                          color: Colors.black),
                                                                    ),),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:  EdgeInsets.only(top: 15.sp,bottom: 15.sp),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: 40.sp,
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: GestureDetector(
                                                              onTap: (){

                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Center(
                                                                    child: Padding(
                                                                      padding:  EdgeInsets.only(left: 15.sp,right: 15.sp),
                                                                      child: Text(' Contact Agent',
                                                                        style: GoogleFonts.poppins(
                                                                          textStyle: TextStyle(
                                                                              fontSize: TextSizes.textmedium,
                                                                              fontWeight: FontWeight.normal,
                                                                              color: Colors.black),
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Container(
                                                          color: Colors.white,

                                                          height: 40.sp,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: GestureDetector(
                                                              onTap: (){

                                                              },
                                                              child: Row(
                                                                children: [

                                                                  Center(
                                                                    child: Padding(
                                                                      padding:  EdgeInsets.only(left: 15.sp,right: 15.sp),
                                                                      child: Text('View Location',
                                                                        style: GoogleFonts.poppins(
                                                                          textStyle: TextStyle(
                                                                              fontSize: TextSizes.textmedium,                                                fontWeight: FontWeight.normal,
                                                                              color: Colors.black),
                                                                        ),),
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
                                      _dotPosition = val;
                                    },);
                                  }

                              )),
                            ),
                          ),
                          const SizedBox(height: 1),
                          // DotsIndicator(
                          //   dotsCount: _images.isEmpty?1:_images.length,
                          //   position: _dotPosition,
                          //   decorator: const DotsDecorator(
                          //     activeColor: Colors.orange,
                          //     color: Colors.blueGrey,
                          //     spacing: EdgeInsets.all(2),
                          //     activeSize: Size(8, 8),
                          //     size: Size(6, 6),
                          //   ),
                          // ),
                        ]


                    ),
                  )




                ],
              ),
            ),
          ),
        ),
      ),

      bottomSheet: Container(
      height: 50.sp,
      color: HexColor('#f6f6f7'),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Spacer(),

          Padding(
            padding: const EdgeInsets.all(0.0),
            child: GestureDetector(
              onTap: (){

              },
              child: Row(
                children: [
                  Container(
                    height: 40.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp), // Adjust the radius to make it more or less rounded
                      color: HexColor('#212529'), // Set your desired color
                    ),

                    child: Center(
                      child: Padding(
                        padding:  EdgeInsets.only(left: 35.sp,right: 35.sp),
                        child: Row(
                          children: [
                            Icon(Icons.call,color: Colors.white,),
                            SizedBox(width: 5.sp,),
                            Text(' Contact Agent',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: TextSizes.textmedium,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),

        ],
      ),

    ),


    );
  }
}