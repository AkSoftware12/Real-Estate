import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:realestate/Model/image_model.dart';
import 'package:realestate/Property%20Deatils/property_deatils.dart';

class AllImageProperty extends StatefulWidget {
  final List<ImageModel> items;
  const AllImageProperty({super.key, required this.items,});


  @override
  State<AllImageProperty> createState() => _AllImagePropertyState();
}

class _AllImagePropertyState extends State<AllImageProperty> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('All Image Property'),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
          itemBuilder: (BuildContext context,index){
            return  Container(
              height: 160.sp,
              width: double.infinity,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),

              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 160.sp,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.items[index].imageUrl.toString(),
                        height: 160.sp,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
            );
          })
    );
  }
}
