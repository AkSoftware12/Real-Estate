import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/All%20Property/all_property.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Search/search.dart';
import 'package:realestate/Utils/textSize.dart';

class CityGrid extends StatefulWidget {
  final String backButton;
  const CityGrid({super.key, required this.backButton});

  @override
  State<CityGrid> createState() => _CityGridState();
}

class _CityGridState extends State<CityGrid> {
  final List<Map<String, String>> cities = [
    {'name': 'Dehradun', 'icon': 'assets/dehradun.png'},
    {'name': 'Mumbai', 'icon': 'assets/mumbai.png'},
    {'name': 'Chandigarh', 'icon': 'assets/chandigarh.png'},
    {'name': 'New Delhi', 'icon': 'assets/newDelhi.png'},
    {'name': 'Bangalore', 'icon': 'assets/banglore.png'},
    {'name': 'Noida', 'icon': 'assets/noida.png'},
    {'name': 'Gurgaon', 'icon': 'assets/gurgaon.png'},
    {'name': 'Kolkata', 'icon': 'assets/kolkata.png'},
    {'name': 'Pune', 'icon': 'assets/pune.png'},
    {'name': 'Chennai', 'icon': 'assets/chennai.png'},
    {'name': 'Hyderabad', 'icon': 'assets/hydrabad.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  (widget.backButton == 'back')?HexColor('#f6f6f7'):Colors.white,

      appBar: (widget.backButton == 'back')?
    AppBar(
      backgroundColor: HexColor('#f6f6f7'),
      title: Text(
        'Popular Cities',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Padding(
          padding:  EdgeInsets.only(right: 8.sp),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  SearchScreen(backButton: 'back')),);

            },
              child: Icon(Icons.search,size: 25.sp,)),
        ),
      ],
    ): null,
      body:GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return CityIcon(
            name: cities[index]['name'].toString(),
            iconPath: cities[index]['icon']!,
          );
        },
      ),
    );
  }
}

class CityIcon extends StatelessWidget {
  final String name;
  final String iconPath;

  CityIcon({required this.name, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ApartmentListing(backButton: 'back')),);

      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(15.sp),
                child: Image.asset(iconPath, height: 50, width: 50),
              )),
          SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.radioCanada(
              // Replace with your desired Google Font
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: TextSizes.textmedium,
                // Adjust font size as needed
                fontWeight: FontWeight.normal, // Adjust font weight as needed
                // Adjust font color as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}
