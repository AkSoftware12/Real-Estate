import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Utils/textSize.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _PropertySearchScreenState createState() => _PropertySearchScreenState();
}

class _PropertySearchScreenState extends State<SearchScreen> {
  String selectedPropertyType = 'Flat';
  String selectedBedroom = '1 Bhk';
  int minBudget = 5000;
  int maxBudget = 7000;
  double start = 5000.0;
  double end = 50000.0;

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
      for (int i = 0; i < _isSelectedPro.length; i++) {
        _isSelectedPro[i] = i == index;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ToggleButtons(
                    isSelected: _isSelected,
                    onPressed: _handleToggleButton,
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
                padding: const EdgeInsets.all(16.0),
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
                              textStyle: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                            decoration: const InputDecoration(
                              hintText: 'eg.Dehradun,Uttarakhand',
                              border: InputBorder.none,
                              prefixIcon:
                              Icon(Icons.search, color: Colors.black),
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
              SizedBox(height: 20),
              Padding(
                padding:  EdgeInsets.only(top: 18.sp,left: 15.sp),
                child: Row(
                  children: [
                    Text(
                      "Property Type",
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
                      padding:  EdgeInsets.only(left: 18.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ToggleButtons(
                            isSelected: _isSelectedPro,
                            onPressed: _handleToggleButtonPro,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    width: 100.sp,
                                    child: Center(child: Row(
                                      children: [
                                        Icon(Icons.home_outlined),
                                        SizedBox(width: 5.sp,),
                                        Center(
                                          child: Text(' Flats',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: TextSizes.textsmall,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),),
                                        ),

                                      ],
                                    ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    width: 100.sp,
                                    child: Center(child: Row(
                                      children: [
                                        Icon(Icons.home_outlined),
                                        SizedBox(width: 5.sp,),
                                        Center(
                                          child: Text(' House',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: TextSizes.textsmall,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                            ),),
                                        ),

                                      ],
                                    ))),
                              ),


                            ],
                          ),
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
              Padding(
                padding:  EdgeInsets.only(top: 18.sp,left: 15.sp),
                child: Row(
                  children: [
                    Text(
                      "Bedrooms",
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

              Wrap(
                spacing: 10.0,
                children: List<Widget>.generate(6, (int index) {
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${index + 1} Bhk',style: TextStyle(color: Colors.black),),
                      ),
                      selected: selectedBedroom == '${index + 1} Bhk',
                      onSelected: (bool selected) {
                        setState(() {
                          selectedBedroom = '${index + 1} Bhk';
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
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
                          width: 120.sp,
                          child: Card(
                            elevation: 4,
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
                      max: 50000.0,
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
                      backgroundColor: HexColor('#ffc107'),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Text(
                    "Search",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.normal, color: Colors.black),
                    ),
                  ),
                  onPressed: () async {
                    // if (formKey.currentState!.validate()) {
                    //   loginUser(context);
                    // }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Homepage()),
                    // );
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