import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/ForgotPassword/forgot_password.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/HomePage/home_page.dart';
import 'package:realestate/RegisterPage/register_page.dart';
import 'package:realestate/Utils/color.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final _focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 300.sp,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background/auth_bg.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login here",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          Text(
                            "Login with your correct credentials",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 20.sp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 13.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Login id",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.normal, color: Colors.black),
                          ),
                        ),
                        Text('')
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#ffc107'),
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
                          child: Stack(
                            children: [
                              Positioned(
                                left: 10,
                                child: Container(
                                  width: double.infinity,
                                  height: 50.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
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
                                        textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter your email',
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.email, color: Colors.black),
                                      ),
                                        textInputAction: TextInputAction.next, // This sets the keyboard action to "Next"
                                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Password",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.normal, color: Colors.black),
                          ),
                        ),
                        Text('')
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    // Remove GestureDetector from wrapping Scaffold





                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#ffc107'),
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
                          child: Stack(
                            children: [
                              Positioned(
                                left: 10,
                                child: Container(
                                  width: double.infinity,
                                  height: 50.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.orange.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
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
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.lock, color: Colors.black),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter your password',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordPage()),);
                          },
                          child: Text(
                            "Forgot password?",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: HexColor('#f04949')),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.sp),
                    SizedBox(
                      width: double.infinity,
                      height: 50.sp,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor('#ffc107'),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal, color: Colors.black),
                          ),
                        ),
                        onPressed: () async {
                          // if (formKey.currentState!.validate()) {
                          //   loginUser(context);
                          // }

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    Container(
                      height: 25.sp,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.grey.shade100,
                                    Colors.black54,
                                    Colors.grey.shade100,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              color: HexColor('#122636'),
                              height: 25.sp,
                              width: 40.sp,
                              child: Center(
                                child: Text(
                                  "OR",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    Text.rich(TextSpan(
                      text: "Don't have an account? ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: HexColor('#9ba3aa')),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Sign up",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal, color: Colors.black),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()),);

                            },
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
