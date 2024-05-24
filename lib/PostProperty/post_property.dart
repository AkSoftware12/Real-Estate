import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/Utils/textSize.dart';
import 'dart:io';

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
      for (int i = 0; i < _isSelectedPro.length; i++) {
        _isSelectedPro[i] = i == index;
      }
    });
  }

  final List<String> propertyOptions = [
    'House',
    'Villa',
    'Hotel',
    'Cottage',
    'Apartment',
  ];

  String selectedProperty = 'House';

  Item? _selectedItem;
  Item? _selectedfacing;
  Item? _selectedfloor;
  Item? _selectedbeds;
  Item? _selectedkitchen;
  Item? _selectedbathroom;
  Item? _selectedcarParking;

  // Define the items for the dropdown list
  List<Item> _items = [
    Item('Residential', '1'),
    Item('Commercial', '0'),
  ];
  List<Item> facing = [
    Item('North', '1'),
    Item('West', '2'),
    Item('South', '3'),
    Item('East', '4'),
  ];
  List<Item> beds = [
    Item('1', '1'),
    Item('2', '2'),
    Item('3', '3'),
    Item('4', '4'),
  ];
  List<Item> kitchen = [
    Item('1', '1'),
    Item('2', '2'),
    Item('3', '3'),
    Item('4', '4'),
  ];
  List<Item> bathroom = [
    Item('1', '1'),
    Item('2', '2'),
    Item('3', '3'),
    Item('4', '4'),
  ];
  List<Item> carParking = [
    Item('1', '1'),
    Item('2', '2'),
    Item('3', '3'),
    Item('4', '4'),
  ];
  List<Item> floor = [
    Item('1', '1'),
    Item('2', '2'),
    Item('3', '3'),
    Item('5', '4'),
    Item('6', '4'),
    Item('7', '4'),
    Item('8', '4'),
    Item('9', '4'),
    Item('10', '4'),
  ];

  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.only(top: 10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ToggleButtons(
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
                                padding: const EdgeInsets.all(16.0),
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
                                padding: const EdgeInsets.all(16.0),
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
              //  1

              // 2
              Padding(
                padding: EdgeInsets.only(top: 18.sp, left: 5.sp),
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

              Wrap(
                spacing: 10.0,
                children:
                    List<Widget>.generate(propertyOptions.length, (int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      label: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          propertyOptions[index],
                          style: TextStyle(
                            color: selectedProperty == propertyOptions[index]
                                ? Colors.white
                                : Colors
                                    .black, // Change text color based on selection
                          ),
                        ),
                      ),
                      selected: selectedProperty == propertyOptions[index],
                      selectedColor: HexColor('#122636'),
                      // Change to your desired selected color
                      checkmarkColor: Colors.white,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedProperty = propertyOptions[index];
                        });
                      },
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 20),
              // 2

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 155.sp,
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
                                          left: 5,
                                          child: Container(
                                            width: 145.sp,
                                            height: 50.sp,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Colors.orange.withOpacity(0.5),
                                              //     spreadRadius: 2,
                                              //     blurRadius: 7,
                                              //     offset: Offset(0, 3),
                                              //   ),
                                              // ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.sp, right: 8.sp),
                                    child: Container(
                                      width: 125.sp,
                                      height: 50.sp,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.sp, right: 0.sp),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<Item>(
                                            isExpanded: true,
                                            value: _selectedItem,
                                            onChanged: (Item? newValue) {
                                              setState(() {
                                                _selectedItem = newValue;
                                              });
                                            },
                                            items: _items.map((Item item) {
                                              return DropdownMenuItem<Item>(
                                                value: item,
                                                child: Text(
                                                  '${item.item}',
                                                  style:
                                                      GoogleFonts.radioCanada(
                                                    // Replace with your desired Google Font
                                                    textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          TextSizes.textsmall2,
                                                      // Adjust font size as needed
                                                      fontWeight: FontWeight
                                                          .normal, // Adjust font weight as needed
                                                      // Adjust font color as needed
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            hint: Text(
                                              'Catergory',
                                              style: GoogleFonts.radioCanada(
                                                // Replace with your desired Google Font
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      TextSizes.textsmall2,
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // 2
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 155.sp,
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
                                          left: 5,
                                          child: Container(
                                            width: 145.sp,
                                            height: 50.sp,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Colors.orange.withOpacity(0.5),
                                              //     spreadRadius: 2,
                                              //     blurRadius: 7,
                                              //     offset: Offset(0, 3),
                                              //   ),
                                              // ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.sp, right: 8.sp),
                                    child: Container(
                                      width: 125.sp,
                                      height: 50.sp,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.sp, right: 0.sp),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<Item>(
                                            isExpanded: true,
                                            value: _selectedItem,
                                            onChanged: (Item? newValue) {
                                              setState(() {
                                                _selectedItem = newValue;
                                              });
                                            },
                                            items: _items.map((Item item) {
                                              return DropdownMenuItem<Item>(
                                                value: item,
                                                child: Text(
                                                  '${item.item}',
                                                  style:
                                                      GoogleFonts.radioCanada(
                                                    // Replace with your desired Google Font
                                                    textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          TextSizes.textsmall2,
                                                      // Adjust font size as needed
                                                      fontWeight: FontWeight
                                                          .normal, // Adjust font weight as needed
                                                      // Adjust font color as needed
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            hint: Text(
                                              'Catergory',
                                              style: GoogleFonts.radioCanada(
                                                // Replace with your desired Google Font
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      TextSizes.textsmall2,
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 155.sp,
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
                                          left: 5,
                                          child: Container(
                                            width: 145.sp,
                                            height: 50.sp,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Colors.orange.withOpacity(0.5),
                                              //     spreadRadius: 2,
                                              //     blurRadius: 7,
                                              //     offset: Offset(0, 3),
                                              //   ),
                                              // ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.sp, right: 8.sp),
                                    child: Container(
                                      width: 125.sp,
                                      height: 50.sp,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.sp, right: 0.sp),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<Item>(
                                            isExpanded: true,
                                            value: _selectedItem,
                                            onChanged: (Item? newValue) {
                                              setState(() {
                                                _selectedItem = newValue;
                                              });
                                            },
                                            items: _items.map((Item item) {
                                              return DropdownMenuItem<Item>(
                                                value: item,
                                                child: Text(
                                                  '${item.item}',
                                                  style:
                                                      GoogleFonts.radioCanada(
                                                    // Replace with your desired Google Font
                                                    textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          TextSizes.textsmall2,
                                                      // Adjust font size as needed
                                                      fontWeight: FontWeight
                                                          .normal, // Adjust font weight as needed
                                                      // Adjust font color as needed
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            hint: Text(
                                              'Catergory',
                                              style: GoogleFonts.radioCanada(
                                                // Replace with your desired Google Font
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      TextSizes.textsmall2,
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // 2
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 155.sp,
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
                                          left: 5,
                                          child: Container(
                                            width: 145.sp,
                                            height: 50.sp,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color: Colors.orange.withOpacity(0.5),
                                              //     spreadRadius: 2,
                                              //     blurRadius: 7,
                                              //     offset: Offset(0, 3),
                                              //   ),
                                              // ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.sp, right: 8.sp),
                                    child: Container(
                                      width: 125.sp,
                                      height: 50.sp,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.sp, right: 0.sp),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<Item>(
                                            isExpanded: true,
                                            value: _selectedItem,
                                            onChanged: (Item? newValue) {
                                              setState(() {
                                                _selectedItem = newValue;
                                              });
                                            },
                                            items: _items.map((Item item) {
                                              return DropdownMenuItem<Item>(
                                                value: item,
                                                child: Text(
                                                  '${item.item}',
                                                  style:
                                                      GoogleFonts.radioCanada(
                                                    // Replace with your desired Google Font
                                                    textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          TextSizes.textsmall2,
                                                      // Adjust font size as needed
                                                      fontWeight: FontWeight
                                                          .normal, // Adjust font weight as needed
                                                      // Adjust font color as needed
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            hint: Text(
                                              'Catergory',
                                              style: GoogleFonts.radioCanada(
                                                // Replace with your desired Google Font
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      TextSizes.textsmall2,
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextField(
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 15.sp,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedItem,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedItem = newValue;
                                    });
                                  },
                                  items: _items.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Catergory',
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
                                ),
                              ),
                            ),
                          ),
                        ),

                        // 2
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedItem,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedItem = newValue;
                                    });
                                  },
                                  items: _items.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Select Catergory',
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
                                ),
                              ),
                            ),
                          ),
                        ),

                        // 3
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedcarParking,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedcarParking = newValue;
                                    });
                                  },
                                  items: carParking.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Car Parking',
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
                                ),
                              ),
                            ),
                          ),
                        ),

                        // 4
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedkitchen,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedkitchen = newValue;
                                    });
                                  },
                                  items: kitchen.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'No Of Kitchen',
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
                                ),
                              ),
                            ),
                          ),
                        ),

                        // 5
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedfloor,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedfloor = newValue;
                                    });
                                  },
                                  items: floor.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Select Floor',
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
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedItem,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedItem = newValue;
                                    });
                                  },
                                  items: _items.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Sub Catergory',
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
                                ),
                              ),
                            ),
                          ),
                        ),
                        // 2
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedItem,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedItem = newValue;
                                    });
                                  },
                                  items: _items.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Select Catergory',
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
                                ),
                              ),
                            ),
                          ),
                        ),

                        // 3
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedbathroom,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedbathroom = newValue;
                                    });
                                  },
                                  items: bathroom.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'No of Bathroom',
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
                                ),
                              ),
                            ),
                          ),
                        ),

                        // 4
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedbeds,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedbeds = newValue;
                                    });
                                  },
                                  items: beds.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'No of Beds',
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
                                ),
                              ),
                            ),
                          ),
                        ),

                        // 5
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 140.sp,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Item>(
                                  isExpanded: true,
                                  value: _selectedfacing,
                                  onChanged: (Item? newValue) {
                                    setState(() {
                                      _selectedfacing = newValue;
                                    });
                                  },
                                  items: facing.map((Item item) {
                                    return DropdownMenuItem<Item>(
                                      value: item,
                                      child: Text(
                                        '${item.item}',
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
                                    );
                                  }).toList(),
                                  hint: Text(
                                    'Select Facing',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
