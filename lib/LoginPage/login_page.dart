import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/Utils/color.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 350,
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
                // Second widget (Text) positioned at the bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    // color: Colors.black.withOpacity(0.5), // Semi-transparent background
                    padding: EdgeInsets.all(16.0), // Adjust padding as needed
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to start (left)
                      children: [
                        Text(
                          "Login here",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold,color: Colors.white),
                          ),

                        ),
                        Text(
                          "Login with your correct credentials",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal,color: Colors.white),
                          ),

                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Login id",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.normal,color: Colors.black),
                        ),
                      ),
                     Text('')
                    ],
                  ),

                  SizedBox(height: 10.0),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Login id',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter Your Email',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Password",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.normal,color: Colors.black),
                        ),
                      ),
                      Text('')
                    ],
                  ),
                  SizedBox(height: 10.0),

                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter Your Password',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle Forgot password action
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),


                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child:  Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal,color: Colors.black),
                        ),

                      ),
                      onPressed: () async {
                        // if (formKey.currentState!.validate()) {
                        //   loginUser(context);
                        //
                        // }
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),

                  Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      // Handle Sign up action
                    },
                    child: Text(
                      "Don’t have an account? Sign up",
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],

      ),
    );
  }
}


