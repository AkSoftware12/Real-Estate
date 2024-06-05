import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Profile%20Update/profile_update.dart';
import 'package:realestate/Utils/textSize.dart';
import 'package:realestate/baseurl/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  final String backButton;
  const AccountPage({super.key, required this.backButton});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  bool _isLoading = false;
  String nickname = '';
  String photoUrl = '';
  String userEmail = '';
  String contact = '';
  String address = '';
  String cityState = '';
  String pin = '';

  @override
  void initState() {
    super.initState();
    fetchProfileData();

  }
  void _refresh() {
    setState(() {
      fetchProfileData();
    });
  }
  Future<void> fetchProfileData() async {

    setState(() {
      _isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(
      'token',
    );
    final Uri uri =
    Uri.parse(getProfile);
    final Map<String, String> headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);

    setState(() {
      _isLoading =
      false; // Set loading state to false after registration completes
    });
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      setState(() {
        nickname= jsonData['user']['name'];
        userEmail = jsonData['user']['email'];
        contact = jsonData['user']['contact'].toString();
        // address = jsonData['user']['bio'];
        photoUrl = jsonData['user']['picture_data'];
      });
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if(widget.backButton== 'back')
              Padding(
                padding:  EdgeInsets.only(bottom: 0.sp),
                child: AppBar(
                  backgroundColor: HexColor('#f6f6f7'),
                  title: Text('Profile',
                    style: TextStyle(
                        color: Colors.black
                    ),),

                ),
              ),
            Stack(
              children: [
                Container(
                  color: HexColor('#f6f6f7'),
                  height: 70.sp,
                ),
                Container(
                  color: Colors.transparent,
                  height: 80.sp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 28.sp),
                            child: Container(
                              height: 60.sp,
                              width: 60.sp,
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50.sp,
                                  width: 50.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      photoUrl.toString(),

                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        // Return a default image widget here
                                        return Container(
                                          color: Colors.grey,
                                          // Placeholder color
                                          // You can customize the default image as needed
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.white,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Text(
                            '${nickname}',
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
                          Spacer(),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProfileUpdatePage(onReturn: _refresh);
                                  },
                                ),
                              );

                            },
                            child: Container(
                              height: 30.sp,
                              width: 30.sp,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Icon(Icons.edit),
                            ),
                          ),
                          SizedBox(
                            width: 15.sp,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top:20.sp, left: 20.sp,bottom: 10.sp),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                        color: HexColor('#f6f6f7'),
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
                      child: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Email Id",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),
                      SizedBox(
                        height:4.sp
                      ),
                      Text.rich(
                        TextSpan(
                          text: "${userEmail}",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.normal, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 28.sp,right: 28.sp,),
              child: Divider(
                height: 1.sp,
                color: Colors.grey.shade200,
              ),
            ),


            Padding(
              padding: EdgeInsets.only(top: 10.sp, left: 20.sp,bottom: 10.sp),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                        color: HexColor('#f6f6f7'),
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
                      child: Icon(Icons.call),
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Contact No",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),
                      SizedBox(
                          height:4.sp
                      ),
                      Text.rich(
                        TextSpan(
                          text: "${contact}",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.normal, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),
                    ],
                  ),              ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 28.sp,right: 28.sp,),
              child: Divider(
                height: 1.sp,
                color: Colors.grey.shade200,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10.sp, left: 20.sp,bottom: 10.sp),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                        color: HexColor('#f6f6f7'),
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
                      child: Icon(Icons.location_on),
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Address",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),

                      SizedBox(
                          height:4.sp
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Dehradun, Rajpur Road, Flat No. 24",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.normal,
                              overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),
                    ],
                  ),              ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 28.sp,right: 28.sp,),
              child: Divider(
                height: 1.sp,
                color: Colors.grey.shade200,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10.sp, left: 20.sp,bottom: 10.sp),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                        color: HexColor('#f6f6f7'),
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
                      child: Icon(Icons.location_city),
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "City / State",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),

                      SizedBox(
                          height:4.sp
                      ),
                      Text.rich(
                        TextSpan(
                          text: "Dehradun, Uttrakhand",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.normal, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),
                    ],
                  ),              ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 28.sp,right: 28.sp,),
              child: Divider(
                height: 1.sp,
                color: Colors.grey.shade200,
              ),
            ),


            Padding(
              padding: EdgeInsets.only(top: 10.sp, left: 20.sp,bottom: 10.sp),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50.sp,
                      width: 50.sp,
                      decoration: BoxDecoration(
                        color: HexColor('#f6f6f7'),
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
                      child: Icon(Icons.pin),
                    ),
                  ),
                  SizedBox(
                    width: 10.sp,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Pin Code",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),

                      SizedBox(
                          height:4.sp
                      ),
                      Text.rich(
                        TextSpan(
                          text: "267867",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: TextSizes.textmedium, // Adjust font size as needed
                              fontWeight: FontWeight.normal, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign.start, // Ensure text starts at the beginning
                      ),
                    ],
                  ),              ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: 28.sp,right: 28.sp,),
              child: Divider(
                height: 1.sp,
                color: Colors.grey.shade200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
