
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:realestate/Commercial/Commercial.dart';
import 'package:realestate/HexColorCode/HexColor.dart';
import 'package:realestate/HomeScreen/home_screen.dart';
import 'package:realestate/PropertyList/residential_property_list.dart';





class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      // Update the selected index when a tab is tapped
      _selectedIndex = _tabController.index;
    });
  }
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(00.0),
            child: Container(
              child: TabBar(
                controller: _tabController,
                indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
                dividerHeight: 0,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                // indicator: BoxDecoration(
                //   color: Colors.orange,
                //   borderRadius: BorderRadius.circular(10),
                // ),
                tabs: [
                  Tab(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0
                            ? HexColor('#122636')
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text('Residential',
                        style: TextStyle(
                          color: _selectedIndex == 0 ? Colors.white : Colors
                              .black,
                        ),
                      ),

                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1
                            ? HexColor('#122636')
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text('Commercial',
                        style: TextStyle(
                          color: _selectedIndex == 1 ? Colors.white : Colors
                              .black,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ResidentialScreen(),
            CommercialScreen(),
          ],
        ),
      ),
    );
  }
}


