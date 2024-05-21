import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Utils/textSize.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                          padding:  EdgeInsets.only(left: 28.sp),
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
                                child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDdGRceHjr8BE1lgHrlDW4gtK5moPuhAxF-g&s',fit: BoxFit.fill,),
                              ),
                            ),

                          ),
                        ),
                        SizedBox(
                          width: 10.sp,
                        ),
                        Text(
                          "James Charley!",
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
                        Container(
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
            padding:  EdgeInsets.only(top: 28.sp,left: 20.sp),
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
                Text('Email Id \n${'Ravikantsaini@gmail.com'}',
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
                  ),),




              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              height: 1.sp,
              color: Colors.grey.shade200,
            ),
          )
        ],
      ),
    );
  }
}
