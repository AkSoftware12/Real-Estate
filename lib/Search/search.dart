import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/All%20Property/all_property.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/SearchProperty/search_property.dart';
import 'package:realestate/Utils/textSize.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:realestate/ApiModel/latlng.dart';
import 'package:realestate/Components/custom_appbar.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:realestate/Themes/constantfile.dart';
import 'package:realestate/baseurl/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchScreen extends StatefulWidget {
  final String backButton;
  const SearchScreen({super.key, required this.backButton});

  @override
  _PropertySearchScreenState createState() => _PropertySearchScreenState();
}

class _PropertySearchScreenState extends State<SearchScreen> {
  String selectedPropertyType = 'Flat';
  String selectedBedroom = '1 Bhk';
  int minBudget = 5000;
  int maxBudget = 7000;
  double start = 5000.0;
  double end = 150000.0;

  bool button = false;
  dynamic lat;
  dynamic lng;

  String selectedCategory = '2';
  List<dynamic> subcategory = [];
  List<dynamic> commercialcategory = [];
  int selectedPropertyIndex = -1;
  int selectedPropertyComIndex = -1;
  int? selectedPropertyId;
  int? selectedPropertyComId;
  var currentAddress = '';
  bool isLoading = true;



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
  Future<void> CommercialCategory() async {
    final response = await http.get(Uri.parse('${category}${'1'}'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['subcategory'];
      setState(() {
        commercialcategory = data;
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }


  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List<bool> _isSelected = [true, false, false];

  void _handleToggleButton(int index) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == index;
      }
    });
  }

  List<bool> _isSelectedPro = [true, false, ];

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


  void getPlaces(context) async {
    // PlacesAutocomplete.show(
    //   context: context,
    //   apiKey: apiKey,
    //   mode: Mode.fullscreen,
    //   onError: (response) {
    //     print(response.predictions);
    //   },
    //   language: "en",
    //     components: [new Component(Component.country, "in")]
    // ).then((value) {
    //   //displayPrediction(value);
    // }).catchError((e) {
    //   print(e);
    // });

    setState(() {
      button = false;
    });

    final Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: apiKey,
      onError: onError,
      mode: Mode.overlay, // or Mode.fullscreen
      language: 'en',
      components: [Component(Component.country, 'in')],
    );

    if (p != null) displayPrediction(p);
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.errorMessage ?? 'Unknown error'),
      ),
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: apiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
    await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    _getCameraMoveLocation(LatLng(lat, lng));
    print("${p.description} - $lat/$lng");

    final marker = Marker(
      markerId: MarkerId('location'),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarker,
    );
    setState(() {
      markers[MarkerId('location')] = marker;
      _goToTheLake(lat, lng);
    });



  }
  void _getCameraMoveLocation(LatLng data) async {
    Timer(Duration(seconds: 1), () async {
      lat = data.latitude;
      lng = data.longitude;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("lat", data.latitude.toStringAsFixed(8));
      prefs.setString("lng", data.longitude.toStringAsFixed(8));
      GeoData data1 = await Geocoder2.getDataFromCoordinates(
          latitude: lat,
          longitude: lng,
          googleMapApiKey: apiKey);
      setState(() {
        currentAddress = data1.address;
        button = true;
      });
    });
  }
  Future<void> _goToTheLake(lat, lng) async {
    final CameraPosition _kLake = CameraPosition(
        target: LatLng(lat, lng),
        zoom: 14.151926040649414);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

  }

  @override
  void initState() {
    super.initState();
    ResidentialCategory();
    CommercialCategory();

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:  Colors.white,

      appBar: (widget.backButton == 'back')?
      AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Search Property',
          style: TextStyle(color: Colors.black),
        ),
      ): null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ToggleButtons(
                    isSelected: _isSelected,
                    onPressed: _handleToggleButton,
                    color: Colors.black, // Color for unselected text/icons
                    selectedColor: Colors.white, // Color for selected text/icons
                    fillColor: HexColor('#122636'), // Background color for selected buttons
                    borderColor: Colors.grey, // Border color for unselected buttons
                    selectedBorderColor: HexColor('#122636'), // Border color for selected buttons
                    borderRadius: BorderRadius.circular(15.0),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            width: 80.sp,
                            child: Center(child: Text('Buy'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            width: 80.sp,
                            child: Center(child: Text('Rent'))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            width: 80.sp,
                            child: Center(child: Text('PG'))),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Text('Selected option: ${_isSelected[0] ? "Buy" : _isSelected[1] ? "Rent" : "PG"}'),
                  // ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(top: 18.sp,left: 15.sp),
                child: Row(
                  children: [
                    Text(
                      "Enter city, state, location",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16,top: 16),
                child: GestureDetector(
                  onTap: (){
                    getPlaces(context);

                  },
                  child: Container(
                    width: double.infinity,
                    height: 50.sp,
                    padding: EdgeInsets.only(left: 15),
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
                        Icon(Icons.search,size: 25,color: Colors.black,),
                        SizedBox(width: 20,),
                        Text(
                          'Enter Location',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              if(currentAddress.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
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
                              left: 5.sp, bottom: 1.sp, top: 5.sp),
                          child: Container(
                            width: screenWidth * 0.7, // 80% of screen width
                            child: Text(
                              currentAddress,
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

                ),
              SizedBox(height: 5),
              Padding(
                padding:  EdgeInsets.only(top: 18.sp,left: 15.sp),
                child: Row(
                  children: [
                    Text(
                      "Property Category",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: 18.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.only(left: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ToggleButtons(
                            isSelected: _isSelectedPro,
                            onPressed: _handleToggleButtonPro,
                            color: Colors.black, // Color for unselected text/icons
                            selectedColor: Colors.white, // Color for selected text/icons
                            fillColor: HexColor('#122636'), // Background color for selected buttons
                            borderColor: Colors.grey, // Border color for unselected buttons
                            selectedBorderColor: HexColor('#122636'), // Border color for selected buttons
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
                          )
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Text('Selected option: ${_isSelected[0] ? "Buy" : _isSelected[1] ? "Rent" : "PG"}'),
                    // ),
                  ],
                ),
              ),



              SizedBox(height: 20),
              // 2
              Padding(
                padding: EdgeInsets.only(top: 10.sp, left: 15.sp),
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


              if(selectedCategory=='2')
              Padding(
                padding:  EdgeInsets.only(left: 10.sp,top: 10.sp),
                child: Wrap(
                  spacing: 10.0,
                  children:
                  List<Widget>.generate(subcategory.length, (int index) {
                    return SizedBox(
                      height: 50.sp,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ChoiceChip(
                          label: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
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
              ),

              if(selectedCategory=='1')
                Padding(
                  padding:  EdgeInsets.only(left: 10.sp,top: 10.sp),
                  child: Wrap(
                    spacing: 10.0,
                    children:
                    List<Widget>.generate(commercialcategory.length, (int index) {
                      return SizedBox(
                        height: 50.sp,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ChoiceChip(
                            label: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  commercialcategory[index]['name'],
                                  style: TextStyle(
                                    color: selectedPropertyComIndex == index
                                        ? Colors.white
                                        : Colors
                                        .black, // Change text color based on selection
                                  ),
                                ),
                              ),
                            ),
                            selected: selectedPropertyComIndex == index,
                            selectedColor: HexColor('#122636'),
                            // Change to your desired selected color
                            checkmarkColor: Colors.white,
                            onSelected: (bool selected) {
                              setState(() {
                                selectedPropertyComId = selected
                                    ? commercialcategory[index]['id']
                                    : commercialcategory[0]['id'];
                                selectedPropertyComIndex = selected ? index : -1;

                              });
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

              Text(selectedPropertyComId.toString(),style: TextStyle(
                color: Colors.black
              ),),
              // 2
              Text(selectedPropertyId.toString(),style: TextStyle(
                  color: Colors.black
              ),),
              SizedBox(height: 40),
              Padding(
                padding:  EdgeInsets.only(left: 20.sp,right: 20.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Min Budget',
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),),
                        SizedBox(height:10.sp,),
                        Container(
                          width: 120.sp,
                          child: Card(
                            elevation: 4,
                            color: Colors.white,
                            child:  Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "₹  " +
                                    start.toStringAsFixed(2),
                                style: GoogleFonts.radioCanada(
                                  // Replace with your desired Google Font
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: TextSizes.textmedium,
                                    // Adjust font size as needed
                                    fontWeight: FontWeight
                                        .normal, // Adjust font weight as needed
                                    // Adjust font color as needed
                                  ),
                                ),
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('Max Budget',
                          style: GoogleFonts.radioCanada(
                            // Replace with your desired Google Font
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: TextSizes.textmedium,
                              // Adjust font size as needed
                              fontWeight: FontWeight
                                  .normal, // Adjust font weight as needed
                              // Adjust font color as needed
                            ),
                          ),),
                        SizedBox(height: 10.sp,),
                        Container(
                          width: 130.sp,
                          child: Card(
                            elevation: 4,
                            color: Colors.white,
                            child:  Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "₹  " +
                                    end.toStringAsFixed(2),
                                style: GoogleFonts.radioCanada(
                                  // Replace with your desired Google Font
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: TextSizes.textmedium,
                                    // Adjust font size as needed
                                    fontWeight: FontWeight
                                        .normal, // Adjust font weight as needed
                                    // Adjust font color as needed
                                  ),
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

              Padding(
                padding:  EdgeInsets.only(top: 18.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RangeSlider(
                      values: RangeValues(start, end),
                      labels: RangeLabels(start.toString(), end.toString()),
                      onChanged: (value) {
                        setState(() {
                          start = value.start;
                          end = value.end;
                        });
                      },
                      min: 2000.0,
                      max: 500000.0,
                      activeColor: HexColor('#122636'),// Color of the active part of the slider
                      inactiveColor: Colors.grey, // Color of the inactive part of the slider
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50.sp,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('#122636'),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Text(
                    "Search",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal, color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    // if (formKey.currentState!.validate()) {
                    //   loginUser(context);
                    // }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchProperty(category_id: selectedCategory,
                        sub_category_id: selectedPropertyId.toString(), min_price: start.toStringAsFixed(2), max_price: end.toStringAsFixed(2), address: currentAddress, buyRentStatus: '0',)),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}