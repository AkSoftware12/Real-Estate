import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realestate/Account/account.dart';
import 'package:realestate/AddProperty/post_property.dart';
import 'package:realestate/All%20Property/all_property.dart';
import 'package:realestate/ApiModel/latlng.dart';
import 'package:realestate/ChangePassword/change_password.dart';
import 'package:realestate/ForgotPassword/forgot_password.dart';
import 'package:realestate/HomePage/home_page.dart';
import 'package:realestate/HomeScreen/home_screen.dart';
import 'package:realestate/Location/location.dart';
import 'package:realestate/LocationPage/location_page.dart';
import 'package:realestate/LoginPage/login_page.dart';
import 'package:realestate/NotificationScreen/notification.dart';
import 'package:realestate/Profile%20Update/profile_update.dart';
import 'package:realestate/Property%20Deatils/property_deatils.dart';
import 'package:realestate/Search/search.dart';
import 'package:realestate/Utils/color.dart';
import 'package:realestate/Utils/string.dart';
import 'package:realestate/Utils/textSize.dart';
import 'package:realestate/baseurl/baseurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;







class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}
class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);


  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Timer? _timer;

  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isExpanded = false;
  bool _isExpandedRent  = false;
  bool _isExpandedNewProject  = false;
  bool _isExpandedLocation  = false;
  bool _isExpandedAccount = false;

  bool _isLoading = false;
  String nickname = '';
  String photoUrl = '';
  late GoogleMapController mapController;
  LatLng _currentPosition = LatLng(0, 0);
  Position? currentLocation;
  String _currentAddress = "Searching...";
  String? cityName = 'Searching...';






  double userLat = 0.0;
  double userLng = 0.0;
  var lat = 30.3253;
  var lng = 78.0413;

  double? lngCut = 0.0;
  double? latCut = 0.0;


  final List<String> items = ['1 Bhk', '2 Bhk', '3 Bhk', '4 Bhk', '5 Bhk'];
  final List<String> project = ['Flats', 'Houses', 'Villas',];
  final List<String> location = ['Dehradun', 'Chandigarh', 'Delhi','Mumbai'];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions() {
    return <Widget>[
      HomeScreen(
        lat: latCut.toString(),
        lng: lngCut.toString(),
      ),
      ApartmentListing(backButton: '',),
      SearchScreen(backButton: '',),
      CityGrid(backButton: '',),
      AccountPage(backButton: '',),

    ];
  }


  Future<void> logoutApi(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
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
      // Replace 'your_token_here' with your actual token
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final Uri uri = Uri.parse(logout);
      final Map<String, String> headers = {'Authorization': 'Bearer $token'};

      final response = await http.post(uri, headers: headers);

      Navigator.pop(context); // Close the progress dialog

      if (response.statusCode == 200) {

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('isLoggedIn',);




        // If the server returns a 200 OK response, parse the data
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginPage();
            },
          ),
        );
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load data');
      }
    } catch (e) {
      Navigator.pop(context); // Close the progress dialog
      // Handle errors appropriately
      print('Error during logout: $e');
      // Show a snackbar or display an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to log out. Please try again.'),
      ));
    }
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
        // userEmail = jsonData['user']['email'];
        // contact = jsonData['user']['contact'].toString();
        // address = jsonData['user']['bio'];
        photoUrl = jsonData['user']['picture_data'];
      });
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _refresh();
    });
  }

  void _refresh() {
    setState(() {
      fetchProfileData();
    });
  }
  @override
  void initState() {
    super.initState();
    _startTimer();
    _getLocation(context);
    fetchProfileData();

    _getCurrentLocation().then((_) {
      // Once the current location is obtained, update the initial camera position
      setState(() {
        _updateCameraPosition(_currentPosition);
      });
    });
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
      // _addMarker(_currentPosition);
      currentLocation = position;
      latCut = position.latitude;
      lngCut = position.longitude;

    });

    _getAddressFromLatLng(_currentPosition);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress ="${place.subLocality}, ${place.locality} ";

        // "${place.street},${place.subLocality}, ${place.locality}, ${place.administrativeArea},${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }


  void _getLocation(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      bool isLocationServiceEnableds =
      await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnableds) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);

        double lt = position.latitude;
        String latstring = lt.toStringAsFixed(8); // '2.35'
        double lats = double.parse(latstring);

        double ln = position.longitude;
        String lanstring = ln.toStringAsFixed(8); // '2.35'
        double lngs = double.parse(lanstring);

        prefs.setString("lat", latstring);
        prefs.setString("lng", lanstring);

        setState(() {
          lat = lats;
          lng = lngs;
        });

        //double lat = position.latitude;
        //double lat = 29.006057;
        //double lng = position.longitude;
        //double lng = 77.027535;

        List<Placemark> placemarks = await placemarkFromCoordinates(lats, lngs);
        setState(() {
          cityName = (placemarks.elementAt(0).subLocality.toString()) +
              " ( " +
              (placemarks.elementAt(0).locality.toString()) +
              " )".toUpperCase();

          prefs.setString("addr", cityName.toString());
        });
      } else {
        await Geolocator.openLocationSettings().then((value) {
          if (value) {
            _getLocation(context);
          } else {
            // Toast.show('Location permission is required!', context,
            //     duration: Toast.LENGTH_SHORT);
          }
        }).catchError((e) {
          // Toast.show('Location permission is required!', context,
          //     duration: Toast.LENGTH_SHORT);
        });
      }
    } else if (permission == LocationPermission.denied) {
      LocationPermission permissiond = await Geolocator.requestPermission();
      if (permissiond == LocationPermission.whileInUse ||
          permissiond == LocationPermission.always) {
        _getLocation(context);
      } else {
        // Toast.show('Location permission is required!', context,
        //     duration: Toast.LENGTH_SHORT);
      }
    } else if (permission == LocationPermission.deniedForever) {
      // await Geolocator.openAppSettings().then((value) {
      //   _getLocation(context);
      // }).catchError((e) {
      //   // Toast.show('Location permission is required!', context,
      //   //     duration: Toast.LENGTH_SHORT);
      // });
    }
  }
  void getBackResult(latss, lngss) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double lats = double.parse(prefs.getString('lat')!);
    double lngs = double.parse(prefs.getString('lng')!);
    //
    // prefs.setString("lat", latss.toStringAsFixed(8));
    // prefs.setString("lng", lngss.toStringAsFixed(8));

    print("LATLONG" + lat.toString() + lng.toString());
    List<Placemark> placemarks = await placemarkFromCoordinates(lats, lngs);

    print("LATLONG" + placemarks.toString());

    setState(() {
      cityName = (placemarks.elementAt(0).subLocality.toString()) +
          " ( " +
          (placemarks.elementAt(0).locality.toString()) +
          " )".toUpperCase();
      prefs.setString("addr", cityName.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // Border radius for rounded corners
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 2, // Border width
                  ),
                ),
                width: 30.sp,
                // Container width
                height: 30.sp,
                // Container height
                alignment: Alignment.center,
                // Align child widget to center
                child: Image.asset(
                  "assets/menu.png", // Path to your image asset
                  width: 17.sp, // Image width
                  height: 17.sp, // Image height
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.only(top: 0.0, left: 10.sp),
              child: Container(
                // width: screenWidth * 0.7, // 80% of screen width

                child: GestureDetector(
                  onTap: () async {
                    print("SENDINGLATLNG  " + lat.toString() + lng.toString());
                    BackLatLng back = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LocationPage(lat, lng)));

                    getBackResult(back.lat, back.lng);
                  },
                  child: Text.rich(TextSpan(
                    text: '${''}${cityName}',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: TextSizes.textsmall,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  )),
                ),
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.location_searching,
                color: Colors.black,
                size: 25.sp,
              ),
              onPressed: () {
                // _getCurrentPosition();
                // _getCurrentLocation();
                _getLocation(context);
              },
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreen()),);

              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // Border radius for rounded corners
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 2, // Border width
                  ),
                ),
                width: 30.sp,
                // Container width
                height: 30.sp,
                // Container height
                alignment: Alignment.center,
                // Align child widget to center
                child: Image.asset(
                  "assets/notification.png", // Path to your image asset
                  width: 20.sp, // Image width
                  height: 20.sp, // Image height
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[],
      ),


      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: const Color(0xFF222B40),
                child: Padding(
                  padding: EdgeInsets.only(top: 50.sp, bottom: 20.sp),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountPage(backButton: 'back',)),);

                      },
                      child: CircleAvatar(
                        radius: 30, // Adjust the radius as needed
                        backgroundImage: (photoUrl.isNotEmpty)?
                        NetworkImage(photoUrl): NetworkImage('https://icons.veryicon.com/png/o/internet--web/prejudice/user-128.png')
                       // Provide your image path
                      ),
                    ),
                    title: Text(
                      "Hi, ${nickname}!",
                      style: GoogleFonts.radioCanada(
                        // Replace with your desired Google Font
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: TextSizes.textmedium,
                          // Adjust font size as needed
                          fontWeight: FontWeight
                              .normal, // Adjust font weight as needed
                          // Adjust font color as needed
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the drawer
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                      // );
                    },
                  ),
                ),
              ),

              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[

                    Divider(
                      color: Colors.grey.shade300,
                      // Set the color of the divider
                      thickness: 1.0,
                      // Set the thickness of the divider
                      height: 1, // Set the height of the divider
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.menu_outlined,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Home",
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
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),



                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Login",
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
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()),);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.account_circle,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "Profile ",
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
                              ],
                            );


                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp),
                            child: Container(
                              height: 90.sp,
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountPage(backButton: 'back',)),);

                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,top: 15.sp,bottom: 10.sp),
                                          child: Text(
                                            "View Profile ",
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
                                    ],
                                  ),
                                  SizedBox(height: 5.sp,),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileUpdatePage(onReturn: () {  },)),);

                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,bottom: 15.sp),
                                          child: Text(
                                            "Edit Profile ",
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
                                    ],
                                  ),

                                ],
                              ),

                            ),
                          ),
                          isExpanded: _isExpanded,
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedRent = !_isExpandedRent;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.home,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "Properties For Rent  ",
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
                              ],
                            );

                            //   ListTile(
                            //   leading: Icon(
                            //     Icons.account_circle,
                            //     color: Colors.black,
                            //   ),
                            //   title:Text(
                            //     " Profile ",
                            //     style: GoogleFonts.poppins(
                            //       // Replace with your desired Google Font
                            //       textStyle: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: TextSizes.textmedium,
                            //         // Adjust font size as needed
                            //         fontWeight: FontWeight
                            //             .normal, // Adjust font weight as needed
                            //         // Adjust font color as needed
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp,),
                            child: Container(
                              height: 180.sp,
                              color: Colors.grey.shade200,
                              child:ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (BuildContext context,int index){
                                    return GestureDetector(
                                      onTap: (){

                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(bottom: 10.sp),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(items[index],
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
                                    );

                                  }),

                            ),
                          ),
                          isExpanded: _isExpandedRent,
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedNewProject = !_isExpandedNewProject;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.calendar_view_week_sharp,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "New projects ",
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
                              ],
                            );

                            //   ListTile(
                            //   leading: Icon(
                            //     Icons.account_circle,
                            //     color: Colors.black,
                            //   ),
                            //   title:Text(
                            //     " Profile ",
                            //     style: GoogleFonts.poppins(
                            //       // Replace with your desired Google Font
                            //       textStyle: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: TextSizes.textmedium,
                            //         // Adjust font size as needed
                            //         fontWeight: FontWeight
                            //             .normal, // Adjust font weight as needed
                            //         // Adjust font color as needed
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp,),
                            child: Container(
                              height: 150.sp,
                              color: Colors.grey.shade200,
                              child:ListView.builder(
                                  itemCount: project.length,
                                  itemBuilder: (BuildContext context,int index){
                                    return GestureDetector(
                                      onTap: (){

                                      },
                                      child: Padding(
                                        padding:  EdgeInsets.only(bottom: 10.sp),
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,bottom: 10.sp),
                                          child: Text(project[index],
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
                                    );

                                  }),

                            ),
                          ),
                          isExpanded: _isExpandedNewProject,
                        ),
                      ],
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedLocation = !_isExpandedLocation;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.location_on,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "Explore localities ",
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
                              ],
                            );

                            //   ListTile(
                            //   leading: Icon(
                            //     Icons.account_circle,
                            //     color: Colors.black,
                            //   ),
                            //   title:Text(
                            //     " Profile ",
                            //     style: GoogleFonts.poppins(
                            //       // Replace with your desired Google Font
                            //       textStyle: TextStyle(
                            //         color: Colors.black,
                            //         fontSize: TextSizes.textmedium,
                            //         // Adjust font size as needed
                            //         fontWeight: FontWeight
                            //             .normal, // Adjust font weight as needed
                            //         // Adjust font color as needed
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp,),
                            child: Container(
                              height: 200.sp,
                              child:Container(
                                height: 150.sp,
                                color: Colors.grey.shade200,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: 3,
                                          itemBuilder: (BuildContext context,int index){
                                            return GestureDetector(
                                              onTap: (){

                                              },
                                              child: Padding(
                                                padding:  EdgeInsets.only(bottom: 10.sp),
                                                child: Padding(
                                                  padding:  EdgeInsets.only(left: 10.sp,bottom: 10.sp),
                                                  child: Text(location[index],
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
                                            );

                                          }),
                                    ),
                                  Container(
                                    width: double.infinity,
                                    height: 40.sp,
                                    color:  Color(0xFF222B40),
                                    child: Row(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding:  EdgeInsets.only(left: 15.sp),
                                            child: GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> CityGrid(backButton: 'back')),);

                                              },
                                              child: Text(
                                                'Explore More +',
                                                style: GoogleFonts.radioCanada(
                                                  // Replace with your desired Google Font
                                                  textStyle: TextStyle(
                                                    color: Colors.white,
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
                                  )

                                  ],
                                )


                              ),

                            ),
                          ),
                          isExpanded: _isExpandedLocation,
                        ),
                      ],
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.join_full_sharp,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Property Advise ",
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
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.post_add,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Post Property ",
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
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PostProperty()),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpandedAccount = !_isExpandedAccount;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 12.sp),
                                  child: Icon(
                                    Icons.account_box,size: 25.sp,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.sp),
                                  child: Text(
                                    "My Account ",
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
                              ],
                            );


                          },
                          body: Padding(
                            padding:  EdgeInsets.only(left: 10.sp,right: 10.sp),
                            child: Container(
                              height: 90.sp,
                              width: double.infinity,
                              color: Colors.grey.shade200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePasswordPage()),);

                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,top: 15.sp,bottom: 15.sp),
                                          child: Text(
                                            "Change Password ",
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
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordPage()),);

                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.only(left: 10.sp,bottom: 15.sp),
                                          child: Text(
                                            "Forgot Password ",
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
                                    ],
                                  ),

                                ],
                              ),

                            ),
                          ),
                          isExpanded: _isExpandedAccount,
                        ),
                      ],
                    ),


                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.feedback,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Feedback ",
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
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.rate_review,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Rate Us ",
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
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.reviews,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Review ",
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
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Setting ",
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
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.help,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Help ",
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
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.privacy_tip,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Faq's ",
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
                        onTap: () {
                          Navigator.of(context).pop(); // Close the drawer
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => SettingsScreen()),
                          // );
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 1.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Logout ",
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
                        onTap: () {
                          logoutApi(context);

                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 18.sp,right: 18.sp),
                      child: Divider(
                        color: Colors.grey.shade300,
                        // Set the color of the divider
                        thickness: 1.0,
                        // Set the thickness of the divider
                        height: 1, // Set the height of the divider
                      ),
                    ),
                  ],
                ),
              )

              // Add more list items as needed
            ],
          ),
        ),
      ),
      body: _widgetOptions().elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/home_inactive.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/home_active.png",
              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/list.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/list.png",
              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/search.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/search.png",
              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/location.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/location.png",
              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(
              // Use ImageIcon instead of Image.asset
              AssetImage("assets/user.png"),
              // Default icon for unselected state
              size: 30, // Size of the unselected icon
            ),
            activeIcon: ImageIcon(
              // Active icon for selected state
              AssetImage(
                "assets/user.png",
              ),
              size: 30,
              // Size of the selected icon
            ),
            label: '', // Empty label to remove text
          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        selectedFontSize: 0,
        // Set font size to 0 for selected label
        unselectedFontSize: 0,

        // Set font size to 0 for unselected label
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Homepage(),
  ));
}
