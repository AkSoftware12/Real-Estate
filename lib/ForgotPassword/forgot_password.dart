import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/HomePage/home_page.dart';
import 'package:realestate/OtpVerify/otp_verify.dart';
import 'package:realestate/RegisterPage/register_page.dart';
import 'package:realestate/Utils/color.dart';
import 'package:realestate/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {



  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final _focusNode = FocusNode();

  String email = "";

  String password = "";

  bool _isLoading = false;

  Future<void> forgotPasswordApi(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
              // SizedBox(width: 16.0),
              // Text("Logging in..."),
            ],
          ),
        );
      },
    );

    try {
      if (formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        String apiUrl = forgotPassword; // Replace with your API endpoint

        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'email': emailController.text,
          },
        );
        setState(() {
          _isLoading =
          false; // Set loading state to false after registration completes
        });
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = json.decode(response.body);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerifyPage(email: emailController.text,),
            ),
          );



          print('OTP Send successfully!');
          // print(token);
          print(response.body);
        } else {
          Navigator.pop(context); // Close the progress dialog

          // Registration failed
          // You may handle the error response here, e.g., show an error message
          print('otp failed!');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to forgot password in. Please try again.'),
          ));
        }
      }
    } catch (e) {
      setState(() {
        _isLoading =
        false; // Set loading state to false after registration completes
      });
      Navigator.pop(context); // Close the progress dialog
      // Handle errors appropriately
      print('Error during login: $e');
      // Show a snackbar or display an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to log in. Please try again.'),
      )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                              "Forgot Password?",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
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
                            "Email id",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                          ),
                          Text('')
                        ],
                      ),
                      SizedBox(height: 20.sp),
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
                                        controller: emailController ,


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

                      SizedBox(height: 50.sp),
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
                            "Send OTP",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {

                              forgotPasswordApi(context);


                            }

                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
