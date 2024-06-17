import 'dart:async';
import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/HomePage/home_page.dart';
import 'package:realestate/Utils/textSize.dart';
import 'dart:io';

import 'package:realestate/baseurl/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item {
  String item;
  String value;

  Item(this.item, this.value);
}

class PostProperty extends StatefulWidget {
  @override
  State<PostProperty> createState() => _PostPropertyState();
}

class _PostPropertyState extends State<PostProperty> {
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController propertyPriceController = TextEditingController();
  final TextEditingController propertySecurityPriceController =
      TextEditingController();
  final TextEditingController propertyAreaController = TextEditingController();
  final TextEditingController propertyLandmarkController =
      TextEditingController();
  final TextEditingController propertyOwnerNameController =
      TextEditingController();
  final TextEditingController propertyOwnerContactController =
      TextEditingController();
  final TextEditingController propertyOwnerWhatsappContactController =
      TextEditingController();
  final TextEditingController propertyFloorController = TextEditingController();
  final TextEditingController propertyBedroomsController =
      TextEditingController();
  final TextEditingController propertyKitchenController =
      TextEditingController();
  final TextEditingController propertyBathroomController =
      TextEditingController();
  final TextEditingController propertyMessageController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _ownerContactController = TextEditingController();
  final _whatsappController = TextEditingController();
  File? file;

  bool _isWater = false;
  bool _isInvertor = false;
  bool _isSecurity = false;
  bool _isCarParking = false;
  int? parkingValue;
  int? waterValue;
  int? invertorValue;
  int? securityValue;

  String _state = '';
  String _city = '';
  late GoogleMapController mapController;
  LatLng _currentPosition = LatLng(0, 0);
  String _currentAddress = "Searching...";
  bool _isCameraMoving = false;
  Set<Marker> _markers = {};


  String _feedback = '';
  String selectedCategory = '2';
  String subCategory = '2';
  String? id = '';
  String? UserDetails;
  String? state = '';
  String? address = '';
  String? city = '';
  String? pin = '';
  double? lng = 0.0;
  double? lat = 0.0;

  @override
  void initState() {
    super.initState();
    ResidentialCategory();
    Userdata();
    print(id);

    _whatsappController.addListener(_checkPhoneNumber);

    _getCurrentLocation().then((_) {
      // Once the current location is obtained, update the initial camera position
      setState(() {
        _updateCameraPosition(_currentPosition);
      });
    });
  }

  Future<void> Userdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    UserDetails = prefs.getString('data');
  }

  @override
  void dispose() {
    _whatsappController.removeListener(_checkPhoneNumber);
    _ownerContactController.dispose();
    _whatsappController.dispose();
    super.dispose();
  }

  void _checkPhoneNumber() {
    String keyword = _ownerContactController
        .text; // Replace with the number you want to check
    setState(() {
      if (_whatsappController.text == keyword) {
        // _feedback = 'Phone number matches the keyword!';
        _feedback =
            'Owner Contact and Whatsapp number same please different Number!';
      } else {
        _feedback = '';
      }
    });
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  String? _validateMatchingNumbers() {
    if (_ownerContactController.text == _whatsappController.text) {
      return 'Owner Contact and Whatsapp number same please different Number  ';
    }
    return null;
  }

  void _updateCameraPosition(LatLng position) {
    mapController.moveCamera(
      CameraUpdate.newLatLngZoom(
        position,
        15.0, // Adjust the zoom level as needed
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _addMarker(_currentPosition);

      lat = position.latitude;
      lng = position.longitude;
    });

    _getAddressFromLatLng(_currentPosition);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.name}, ${place.street}, "
            "${place.subLocality}, ${place.locality},"
            " ${place.administrativeArea} ${place.postalCode},"
            " ${place.country}";

        state = "${place.administrativeArea}";
        city = "${place.locality}";
        pin = "${place.postalCode}";
        address = "${place.name}, ${place.street},${place.subLocality},";

        // "${place.street},${place.subLocality}, ${place.locality}, ${place.administrativeArea},${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _isCameraMoving = true;
      _currentPosition = position.target;
    });
  }

  void _onCameraIdle() {
    setState(() {
      _isCameraMoving = false;
    });
    _getAddressFromLatLng(_currentPosition);
    _addMarker(_currentPosition);
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: position,
          infoWindow: InfoWindow(
            title: 'Current Location',
            snippet: _currentAddress,
          ),
        ),
      );
    });
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  List<bool> _isSelectedPro = [
    true,
    false,
  ];

  void _handleToggleButtonPro(int index) {
    setState(() {
      for (int buttonIndex = 0;
          buttonIndex < _isSelectedPro.length;
          buttonIndex++) {
        if (buttonIndex == index) {
          _isSelectedPro[buttonIndex] = true;
          // Perform your action based on the selected button
          if (index == 0) {
            selectedCategory = ('2');
          } else if (index == 1) {
            selectedCategory = ('1');
          }
        } else {
          _isSelectedPro[buttonIndex] = false;
        }
      }
    });
  }

  int? selectedPropertyId;

  String _selectedfacing = 'North';
  String _selectedArea = 'sqft';

  bool isFirstSelection = true;
  bool _isLoading = false;
  bool isLoading = true;
  List<dynamic> subcategory = [];
  int selectedPropertyIndex = 0;

  Future<void> ResidentialCategory() async {
    final response = await http.get(Uri.parse('${category}${'2'}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['subcategory'];
      setState(() {
        subcategory = data;
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addPost(List<XFile>? imageFiles) async {
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

    final propertyName = propertyNameController.text;
    final propertyPrice = propertyPriceController.text;
    final propertySecurityPrice = propertySecurityPriceController.text;
    final propertyArea = '${propertyAreaController.text} ${_selectedArea}';
    final propertyLandmark = propertyLandmarkController.text;
    final propertyOwnerName = propertyOwnerNameController.text;
    final propertyOwnerContact = _ownerContactController.text;
    final propertyOwnerWhatsappContact = _whatsappController.text;
    final propertyFloor = propertyFloorController.text;
    final propertyBedrooms = propertyBedroomsController.text;
    final propertyKitchen = propertyKitchenController.text;
    final propertyBathroom = propertyBathroomController.text;
    final propertyMessage = propertyMessageController.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(addProperty),
    );

    // Add token to request headers
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['category_id'] = selectedCategory;
    request.fields['subcategory_id'] = subCategory;
    // request.fields['user_id'] = id!;
    request.fields['property_name'] = propertyName;
    request.fields['property_price'] = propertyPrice;
    request.fields['property_address'] = address!;
    request.fields['property_district'] = city!;
    request.fields['property_state'] = state!;
    request.fields['property_pin'] = pin!;
    request.fields['property_long'] = lng.toString();
    request.fields['property_lat'] = lat.toString();
    request.fields['property_landmark'] = propertyLandmark;
    request.fields['property_facing'] = _selectedfacing;
    request.fields['owner_name'] = propertyOwnerName;
    request.fields['owner_contact'] = propertyOwnerContact;
    request.fields['owner_whatsapp'] = propertyOwnerWhatsappContact;
    request.fields['bulidup_area'] = propertyArea;
    request.fields['floor'] = propertyFloor;
    request.fields['security_amt'] = propertySecurityPrice;
    request.fields['society'] = '';
    request.fields['no_of_beds'] = propertyBedrooms;
    request.fields['no_of_kitchen'] = propertyKitchen;
    request.fields['no_of_bathroom'] = propertyBathroom;
    request.fields['property_description'] = propertyMessage;
    request.fields['buyRentStatus'] = '0';
    request.fields['furniture_status'] = '0';
    request.fields['availability_status'] = '0';
    request.fields['car_parking'] = parkingValue.toString();
    request.fields['water'] = waterValue.toString();
    request.fields['invertor'] = invertorValue.toString();
    request.fields['security'] = securityValue.toString();

    // Add multiple images to the request
    for (var file in imageFiles!) {
      if (file != null) {
        request.files
            .add(await http.MultipartFile.fromPath('images[]', file.path));
      }
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      print("Post added successfully");
    } else {
      print("Failed to add post: ${response.statusCode}");
      print("Response body: ${response.body}");
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: HexColor('#f6f6f7'),
      appBar: AppBar(
        backgroundColor: HexColor('#f6f6f7'),
        title: Text(
          'Add Property',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: true,
        // leading: Icon(
        //   Icons.arrow_back,
        //   color: Colors.black,
        //   size: 20.sp,
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1

              Padding(
                padding: EdgeInsets.only(top: 5.sp, left: 5.sp),
                child: Row(
                  children: [
                    Text(
                      "Property Category",
                      style: GoogleFonts.radioCanada(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: TextSizes.textmedium,
                          // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Adjust font weight as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.sp,
                            child: ToggleButtons(
                              isSelected: _isSelectedPro,
                              onPressed: _handleToggleButtonPro,
                              color: Colors.black,
                              // Color for unselected text/icons
                              selectedColor: Colors.white,
                              // Color for selected text/icons
                              fillColor: HexColor('#122636'),
                              // Background color for selected buttons
                              borderColor: Colors.grey,
                              // Border color for unselected buttons
                              selectedBorderColor: HexColor('#122636'),
                              // Border color for selected buttons
                              borderRadius: BorderRadius.circular(15.0),

                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    width: 100.sp,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          SizedBox(width: 5.sp),
                                          Center(
                                            child: Text(
                                              ' Residential',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: TextSizes.textsmall,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    width: 100.sp,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          SizedBox(width: 5.sp),
                                          Center(
                                            child: Text(
                                              'Commercial',
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: TextSizes.textsmall,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  'Selected option: ${selectedCategory}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  'Selected option: ${selectedPropertyId}',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  'Selected option: ${lat} ${lng}',
                  style: TextStyle(color: Colors.black),
                ),
              ),

              //  1

              // 2
              Padding(
                padding: EdgeInsets.only(top: 10.sp, left: 5.sp),
                child: Row(
                  children: [
                    Text(
                      "Property Type",
                      style: GoogleFonts.radioCanada(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: TextSizes.textmedium,
                          // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Adjust font weight as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Wrap(
                spacing: 10.0,
                children:
                    List<Widget>.generate(subcategory.length, (int index) {
                  return SizedBox(
                    height: 50.0,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: ChoiceChip(
                        label: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            subcategory[index]['name'],
                            style: TextStyle(
                              color: selectedPropertyIndex == index
                                  ? Colors.white
                                  : Colors
                                      .black, // Change text color based on selection
                            ),
                          ),
                        ),
                        selected: selectedPropertyIndex == index,
                        selectedColor: HexColor('#122636'),
                        // Change to your desired selected color
                        checkmarkColor: Colors.white,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedPropertyId = selected
                                ? subcategory[index]['id']
                                : subcategory[0]['id'];
                            selectedPropertyIndex = selected ? index : -1;
                          });
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
              // 2

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Location",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.sp)),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 5.sp, bottom: 15.sp, top: 5.sp),
                            child: Container(
                              width: screenWidth * 0.7, // 80% of screen width
                              child: Text(
                                _currentAddress,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: TextSizes.textsmall,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 180.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 180.sp,
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
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Container(
                            width: double.infinity,
                            height: 180.sp,
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GoogleMap(
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: CameraPosition(
                                  target: _currentPosition,
                                  zoom: 15.0,
                                ),
                                myLocationEnabled: true,
                                myLocationButtonEnabled: true,
                                onCameraMove: _onCameraMove,
                                onCameraIdle: _onCameraIdle,
                                markers: _markers,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

//  3
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Property Name",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 40.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyNameController,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter  Property Name',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Price",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 40.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                Icon(
                                  Icons.currency_rupee_sharp,
                                  size: 20.sp,
                                  color: Colors.black,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyPriceController,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter price',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Security Price",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 40.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                Icon(
                                  Icons.currency_rupee_sharp,
                                  size: 20.sp,
                                  color: Colors.black,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller:
                                          propertySecurityPriceController,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter price',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Buildup Area",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp, // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyAreaController,
                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter area',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: _selectedArea,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedArea = newValue!;
                                    });
                                  },
                                  items: <String>['sqft', 'ft', 'yard']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Landmark",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 40.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyLandmarkController,

                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Near By',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 8

              //  9
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Owner Name",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 40.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyOwnerNameController,

                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Enter Owner Name',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 9

              //  10

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text.rich(
                              TextSpan(
                                text: "Owner Contact",
                                style: GoogleFonts.radioCanada(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: TextSizes.textmedium,
                                    // Adjust font size as needed
                                    fontWeight: FontWeight
                                        .bold, // Adjust font weight as needed
                                  ),
                                ),
                              ),
                              textAlign: TextAlign
                                  .start, // Ensure text starts at the beginning
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 40.sp,
                                decoration: BoxDecoration(
                                  color: HexColor('#122636'),
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
                                        height: 40.sp,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.orange
                                                  .withOpacity(0.5),
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
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: Container(
                                  width: double.infinity,
                                  height: 40.sp,
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: TextFormField(
                                            controller: _ownerContactController,
                                            keyboardType: TextInputType.phone,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Enter Owner Contact Number',
                                              border: InputBorder.none,
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: _validatePhoneNumber,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text.rich(
                              TextSpan(
                                text: "Whatsapp",
                                style: GoogleFonts.radioCanada(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: TextSizes.textmedium,
                                    // Adjust font size as needed
                                    fontWeight: FontWeight
                                        .bold, // Adjust font weight as needed
                                  ),
                                ),
                              ),
                              textAlign: TextAlign
                                  .start, // Ensure text starts at the beginning
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 40.sp,
                                decoration: BoxDecoration(
                                  color: HexColor('#122636'),
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
                                        height: 40.sp,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.orange
                                                  .withOpacity(0.5),
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
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: Container(
                                  width: double.infinity,
                                  height: 40.sp,
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: TextFormField(
                                            controller: _whatsappController,
                                            keyboardType: TextInputType.phone,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Enter Whatsapp Number',
                                              border: InputBorder.none,
                                            ),
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              final validationMessage =
                                                  _validatePhoneNumber(value);
                                              if (validationMessage != null) {
                                                return validationMessage;
                                              }
                                              return _validateMatchingNumbers();
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
                        ],
                      ),
                    ),
                    if (_feedback.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _feedback,
                          style: TextStyle(
                            fontSize: TextSizes.textsmall,
                            color: _feedback.contains('matches')
                                ? Colors.red
                                : Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // 10

              //  11
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Facing",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp, // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedfacing,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedfacing = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'North',
                                    'West',
                                    'South',
                                    'East',
                                    'North-East',
                                    'North-West',
                                    'South-East',
                                    'South-West'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  isExpanded: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 11

              //  12
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Floor",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 40.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyFloorController,

                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Number of Floor',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 12

              //  13
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Bedrooms",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 40.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyBedroomsController,

                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Number of bedrooms',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 13

              //  14
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Kitchen",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 40.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyKitchenController,

                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Number of kitchen',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 14

              //  15
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Bathroom",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 40.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 40.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 40.sp,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyBathroomController,

                                      keyboardType: TextInputType.number,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Number of bathroom',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // 15

              //  16
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text.rich(
                        TextSpan(
                          text: "Message",
                          style: GoogleFonts.radioCanada(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .bold, // Adjust font weight as needed
                            ),
                          ),
                        ),
                        textAlign: TextAlign
                            .start, // Ensure text starts at the beginning
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100.sp,
                          decoration: BoxDecoration(
                            color: HexColor('#122636'),
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
                                  height: 100.sp,
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: double.infinity,
                            height: 100.sp,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      controller: propertyMessageController,

                                      keyboardType: TextInputType.name,
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: TextSizes.textsmall,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'message',
                                        border: InputBorder.none,
                                      ),
                                      textInputAction: TextInputAction.next,
                                      // This sets the keyboard action to "Next"
                                      onEditingComplete: () =>
                                          FocusScope.of(context).nextFocus(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 16

              Card(
                shape: InputBorder.none,
                elevation: 5,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Add Photos',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: TextSizes.textmedium,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${'('}${imageFileList!.length.toString()}${')'}',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: TextSizes.textmedium,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 80.sp,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageFileList!.length + 1,
                        // +1 for "Add Photo" button
                        itemBuilder: (BuildContext context, int index) {
                          // If it's the last item, show the "Add Photo" button
                          if (index == imageFileList!.length) {
                            return GestureDetector(
                              onTap: () {
                                // Simulate adding a photo
                                selectImages();
                              },
                              child: Container(
                                margin: EdgeInsets.all(8.0),
                                width: 70.sp,
                                decoration: BoxDecoration(
                                    color: HexColor('#122636'),
                                    borderRadius: BorderRadius.circular(10.sp)),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          } else {
                            // Show the photo
                            return Container(
                              margin: EdgeInsets.all(8.0),
                              width: 70.sp,
                              height: 70.sp,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10.sp)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  child: Image.file(
                                    File(imageFileList![index].path),
                                    fit: BoxFit.cover,
                                  )),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 18.sp),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: _isWater,
                            activeColor: Colors.orange,
                            onChanged: (bool? value) {
                              setState(() {
                                _isWater = value ?? false;
                                waterValue = _isWater ? 1: 0;

                              });
                            },
                          ),
                          Text(
                            'Water 24/7',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: _isInvertor,
                            activeColor: Colors.orange,
                            onChanged: (bool? value) {
                              setState(() {
                                _isInvertor = value ?? false;
                                invertorValue = _isInvertor ? 1 : 0;

                              });
                            },
                          ),
                          Text(
                            'Invertor',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: _isSecurity,
                            activeColor: Colors.orange,
                            onChanged: (bool? value) {
                              setState(() {
                                _isSecurity = value ?? false;
                                securityValue = _isSecurity ? 1 : 0;

                              });
                            },
                          ),
                          Text(
                            'Security',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.sp, right: 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          value: _isCarParking,
                          activeColor: Colors.orange,
                          onChanged: (bool? value) {
                            setState(() {
                              _isCarParking = value ?? false;
                              parkingValue = _isCarParking ? 1 : 0;
                              // Now you can use parkingValue as needed
                            });
                          },
                        ),
                        Text(
                          'Car Parking',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
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
                    "Submit",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      addPost(imageFileList);
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Validation successful')));
                    }
                  },
                ),
              ),
              SizedBox(height: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
