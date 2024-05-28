import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/HomePage/home_page.dart';
import 'package:realestate/LoginPage/login_page.dart';
import 'package:realestate/baseurl/baseurl.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final _focusNode = FocusNode();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";
  String fullName = "";

  Future<void> _registerUser(BuildContext context) async {


    try {
      if (formKey.currentState!.validate()) {
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
        setState(() {
          _isLoading = true;
        });
        String apiUrl = register; // Replace with your API endpoint

        final response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
          },
        );
        setState(() {
          _isLoading = false; // Set loading state to false after registration completes
        });
        if (response.statusCode == 200) {


          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Homepage(),
            ),
          );
          print('User registered successfully!');
          print(response.body);
        } else {
          // Registration failed
          // You may handle the error response here, e.g., show an error message
          print('Registration failed!');
        }
      }
    } catch (e) {
      Navigator.pop(context); // Close the progress dialog
      // Handle errors appropriately
      print('Error during login: $e');
      // Show a snackbar or display an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to log in. Please try again.'),
      ));
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
                              "Register here",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            Text(
                              "Don't worry Your information will be safe",
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
                            "Full Name",
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
                                      child: TextFormField(
                                        controller: nameController,
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.black),
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Enter your name',
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.black),
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            fullName = val;
                                          });
                                        },

                                        validator: (val) {
                                          if (val!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return "Name cannot be empty";
                                          }
                                        },
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
                            "Email id",
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
                                      child: TextFormField(
                                        controller: emailController,

                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.black),
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Enter your email',
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.email, color: Colors.black),
                                        ),

                                        onChanged: (val) {
                                          setState(() {
                                            email = val;
                                          });
                                        },

                                        // check tha validation
                                        validator: (val) {
                                          return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val!)
                                              ? null
                                              : "Please enter a valid email";
                                        },
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
                                      child: TextFormField(
                                        controller: passwordController,
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.black),
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Enter your password',
                                          border: InputBorder.none,
                                        ),
                                        validator: (val) {
                                          if (val!.length < 6) {
                                            return "Password must be at least 6 characters";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (val) {
                                          setState(() {
                                            password = val;
                                          });
                                        },
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
                            "Contact No",
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
                                        keyboardType: TextInputType.phone,

                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.black),
                                        ),
                                        decoration: InputDecoration(

                                          hintText: 'Enter your Contact No',
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.call, color: Colors.black),
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
                            "Address",
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

                                          hintText: 'Enter Your Address',
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.location_on, color: Colors.black),
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
                            "City / State",
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

                                          hintText: 'Enter Your City or State',
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.location_city, color: Colors.black),
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
                            "Pin Code",
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
                                        keyboardType: TextInputType.number,



                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.normal, color: Colors.black),
                                        ),
                                        decoration: InputDecoration(

                                          hintText: 'Enter Your Pin Code',
                                          border: InputBorder.none,
                                          prefixIcon: Icon(Icons.pin, color: Colors.black),
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
                            "Register",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                          ),
                          onPressed: () async {
                            _registerUser(context);


                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => LoginPage()),
                            // );
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
                        text: "Already have an account ? ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: HexColor('#9ba3aa')),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Sign in",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal, color: Colors.black),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()),);
                              },
                          ),
                        ],
                      )),
                      SizedBox(height: 20.sp),

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
