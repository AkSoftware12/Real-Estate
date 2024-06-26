import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realestate/Account/account.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Utils/color_constants.dart';
import 'package:realestate/Utils/textSize.dart';
import 'package:realestate/baseurl/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUpdatePage extends StatefulWidget {
  final VoidCallback onReturn;

  const ProfileUpdatePage({super.key, required this.onReturn});

  @override
  State<ProfileUpdatePage> createState() => _AccountPageState();
}

class _AccountPageState extends State<ProfileUpdatePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Timer? timer;


  File? file;

  final picker = ImagePicker();

  bool isVisible = false;
  bool isEditing = false;

  String id = '';
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';
  String userEmail = '';
  bool isLoading = false;
  File? avatarImageFile;
  bool _loading = false;
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    fetchProfileData();

  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel timer to prevent memory leaks
    super.dispose();
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
        nameController.text = jsonData['user']['name'];
        emailController.text = jsonData['user']['email'];
        phoneController.text = jsonData['user']['contact'].toString();
        photoUrl = jsonData['user']['picture_data'];
      });

    } else {
      throw Exception('Failed to load profile data');
    }
  }


  Future<void> _updateProfile(File? file) async {
    // Show loading dialog
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

    // Get user input data
    String name = nameController.text;
    String email = emailController.text;
    String phoneNumber = phoneController.text;
    String bio = bioController.text;

    // Get the selected image file

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    // Your API endpoint for updating profile
    String apiUrl = updateProfile;

    try {
      // Create multipart request for image upload
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      // Add other fields to the request
      request.fields.addAll({
        'name': name,
        'email': email,
        'contact': phoneNumber,
        'bio': bio,
      });

      // Add authorization header
      request.headers['Authorization'] = 'Bearer $token';
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('image', file.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);





      // // Send the request
      // var response = await request.send();

      if (response.statusCode == 200) {

        widget.onReturn();
        Navigator.pop(context);


        Fluttertoast.showToast(
          msg: "Update Profile successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 22.0,
        );


        // You can navigate to another screen or show a success message
      } else {
        // Error occurred while updating profile
        print('Failed to update profile. Error: ${response.statusCode}');
        // Handle error accordingly, show error message, etc.
      }
    } catch (e) {
      print('Exception occurred: $e');
      // Handle exception, show error message, etc.
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [

          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: 50.sp),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            color: HexColor('#f6f6f7'),
                            height: 130.sp,
                          ),
                          Container(
                            color: Colors.transparent,
                            height: 210.sp,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Spacer(),
                                Spacer(),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Spacer(),
                                    Stack(fit: StackFit.loose, children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30), // Adjust the radius to make it more or less rounded
                                              color: Colors.white, // Set your desired color
                                            ),
                                            width: 100.sp,height: 100.sp,
                                            margin: EdgeInsets.all(20),
                                            child: file == null
                                                ? photoUrl.isNotEmpty
                                                ? ClipRRect(
                                              borderRadius: BorderRadius.circular(30),
                                              child: Image.network(
                                                photoUrl,
                                                fit: BoxFit.cover,
                                                width:  100.sp,
                                                height: 100.sp,
                                                errorBuilder:
                                                    (context, object, stackTrace) {
                                                  return Image.network(
                                                    'https://media.istockphoto.com/id/1394514999/photo/woman-holding-a-astrology-book-astrological-wheel-projection-choose-a-zodiac-sign-astrology.jpg?s=612x612&w=0&k=20&c=XIH-aZ13vTzkcGUTbVLwPcp_TUB4hjVdeSSY-taxlOo=',
                                                    fit: BoxFit.cover,
                                                    width:  100.sp,
                                                    height: 100.sp,
                                                  );
                                                },
                                                loadingBuilder: (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent? loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Container(
                                                    width: 50.sp,
                                                    height: 50.sp,
                                                    child: Center(
                                                      child: CircularProgressIndicator(
                                                        color:
                                                        ColorConstants.themeColor,
                                                        value: loadingProgress
                                                            .expectedTotalBytes !=
                                                            null
                                                            ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(30),
                                              // Half of width/height for perfect circle
                                              child: Image.network(
                                                'https://media.istockphoto.com/id/1394514999/photo/woman-holding-a-astrology-book-astrological-wheel-projection-choose-a-zodiac-sign-astrology.jpg?s=612x612&w=0&k=20&c=XIH-aZ13vTzkcGUTbVLwPcp_TUB4hjVdeSSY-taxlOo=',
                                                fit: BoxFit.cover,
                                                width:  100.sp,
                                                height:  100.sp,
                                              ),
                                            )
                                                : ClipRRect(
                                              borderRadius: BorderRadius.circular(30),
                                              child: Image.file(
                                                file!,
                                                width: 50.sp,
                                                height: 50.sp,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding:
                                          EdgeInsets.only(top: 100.sp, left: 20.sp),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              InkWell(
                                                  onTap: () {
                                                    _showPicker(context: context);
                                                  },
                                                  child: const CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    radius: 15.0,
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ],
                                          )),
                                    ]),
                                    Spacer(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Align children to start

                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: "Full Name",
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
                            ),
                            Container(
                              height: 55.sp,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the radius to make it more or less rounded
                                color: HexColor('#f6f6f7'),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.man,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                title: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0, right: 25.0, top: 0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: new TextField(
                                              controller: nameController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Admin"),
                                              style: TextStyle(color: Colors.black),

                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),

                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(top: 8.sp),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
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
                              ),
                            ),
                            Container(
                              height: 55.sp,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the radius to make it more or less rounded
                                color: HexColor('#f6f6f7'),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.email,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                title: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0, right: 5.0, top: 0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: new TextField(
                                              controller: emailController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "admin@gmail.com"),
                                              style: TextStyle(color: Colors.black),

                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),

                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(top: 8.sp),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
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
                              ),
                            ),
                            Container(
                              height: 55.sp,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the radius to make it more or less rounded
                                color: HexColor('#f6f6f7'),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.call,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                title: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0, right: 25.0, top: 0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: new TextField(
                                              keyboardType: TextInputType.phone,
                                              controller: phoneController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "+91 234567890"),
                                              style: TextStyle(color: Colors.black),

                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),

                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(top: 8.sp),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
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
                              ),
                            ),
                            Container(
                              height: 55.sp,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the radius to make it more or less rounded
                                color: HexColor('#f6f6f7'),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.location_on,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                title: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0, right: 25.0, top: 0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: new TextField(
                                              controller: bioController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Dehradun, Rajpur Road, Flat No.24"),
                                              style: TextStyle(color: Colors.black),

                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),

                              ),
                            ),


                            Padding(
                              padding:  EdgeInsets.only(top: 8.sp),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
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
                              ),
                            ),
                            Container(
                              height: 55.sp,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the radius to make it more or less rounded
                                color: HexColor('#f6f6f7'),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.location_city,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                title: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0, right: 25.0, top: 0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: new TextField(
                                              controller: bioController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Dehradun / Uttrakhand"),
                                              style: TextStyle(color: Colors.black),

                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),

                              ),
                            ),


                            Padding(
                              padding:  EdgeInsets.only(top: 8.sp),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
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
                              ),
                            ),
                            Container(
                              height: 55.sp,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the radius to make it more or less rounded
                                color: HexColor('#f6f6f7'),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.location_city,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                title: Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.0, right: 25.0, top: 0),
                                    child: new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0),
                                            child: new TextField(
                                              keyboardType: TextInputType.number,
                                              controller: bioController,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "257827"),
                                              style: TextStyle(color: Colors.black),

                                            ),
                                          ),
                                          flex: 2,
                                        ),
                                      ],
                                    )),

                              ),
                            ),

                          ],
                        ),
                      )


                    ],
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding:  EdgeInsets.only(top: 40.sp),
              child: Stack(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10.sp,),
                      GestureDetector(
                          onTap: (){
                            widget.onReturn();
                            Navigator.pop(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30), // Adjust the radius to make it more or less rounded
                                color: Colors.white, // Set your desired color
                              ),


                            height: 30.sp,
                              width: 30.sp,
                              child: Center(child: Icon(Icons.arrow_back)))),

                    ],
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        height: 30.sp,
                        child: Center(
                          child: Text('Profile Update',
                            style: GoogleFonts.radioCanada(
                              // Replace with your desired Google Font
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: TextSizes.textmedium,
                                // Adjust font size as needed
                                fontWeight: FontWeight
                                    .bold, // Adjust font weight as needed
                                // Adjust font color as needed
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 50.sp,
        color: Colors.white,
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);

                },
                child: Row(
                  children: [
                    Container(
                      width: 150.sp,
                      height: 40.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp), // Adjust the radius to make it more or less rounded
                        color: HexColor('#01949A'), // Set your desired color
                      ),

                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.only(left: 35.sp,right: 35.sp),
                          child: Text(' Cancel',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: TextSizes.textmedium,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),

            Padding(
              padding: const EdgeInsets.all(0.0),
              child: GestureDetector(
                onTap: (){
                  _updateProfile(file);
                },
                child: Row(
                  children: [
                    Container(
                      width: 150.sp,
                      height: 40.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp), // Adjust the radius to make it more or less rounded
                        color: HexColor('#212529'), // Set your desired color
                      ),

                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.only(left: 35.sp,right: 35.sp),
                          child: Text(' Save',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: TextSizes.textmedium,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white),
                            ),),
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

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
      ImageSource img,
      ) async {

    setState(() {
      _loading = true; // Show progress indicator
    });

    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
      setState(() {
        _loading = false; // Hide progress indicator
      });
      return null;
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      setState(() {
        file = image;
        isLoading = true;
      });
      // uploadFile();
    }

    setState(() {
      _loading = false; // Hide progress indicator
    });
  }

}
