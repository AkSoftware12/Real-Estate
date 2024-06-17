import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullScreenUserProfile extends StatefulWidget {
  final String image;
  const FullScreenUserProfile({super.key, required this.image});

  @override
  State<FullScreenUserProfile> createState() => _FullScreenUserProfileState();
}

class _FullScreenUserProfileState extends State<FullScreenUserProfile> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.black,
     body: Stack(
       children: [
         AppBar(
             backgroundColor: Colors.black,
           actions: [
             GestureDetector(
                 onTap: (){
                   Navigator.pop(context);
                 },
                 child: Padding(
                   padding: const EdgeInsets.only(right: 18.0),
                   child: Icon(Icons.close,size: 25.sp,color: Colors.white,),
                 )),
           ],


         ),
         Center(
           child: Image.network(widget.image),
         ),
       ],


     ),
   );
  }
}