import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/All%20Property/all_property.dart';
import 'package:realestate/ApiModel/ResidentialPropertyModel/residential_property_model.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Property%20Deatils/property_deatils.dart';
import 'package:realestate/Utils/textSize.dart';
import 'package:http/http.dart' as http;
import 'package:realestate/baseurl/baseurl.dart';

class ResidentialAllProperty extends StatefulWidget {


  ResidentialAllProperty({super.key});

  @override
  State<ResidentialAllProperty> createState() => _ResidentialScreenState();
}

class _ResidentialScreenState extends State<ResidentialAllProperty> {
  bool isLoading = true;
  List<dynamic> allProperty = [];



  @override
  void initState() {
    super.initState();
    allPropertyapi();
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

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text('Residential Property',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back)),

      ),

      body: GridView.count(
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
    );

  }
}