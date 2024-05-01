import 'package:collector/components/Colorpallet.dart';
import 'package:collector/pages/farmerinquiry.dart';
import 'package:collector/pages/hervestcollection.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key, required this.navigationShell})
      : super(
          key: key,
        );

  final StatefulNavigationShell navigationShell;
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [farmereInquiry(), Collection()];

  int selectedIndex = 0;

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: ColorPalette.Jungle_Green,
        selectedIndex: selectedIndex,
        onButtonPressed: (int index) {
          setState(() {
            selectedIndex = index;
          });
          _goToBranch(selectedIndex);
        },
        inactiveColor: Colors.white,
        activeColor: Colors.white,
        iconSize: 30,
        barItems: [
          BarItem(
            icon: Icons.shopping_basket,
            title: 'Colletor',
          ),
          BarItem(
            icon: Icons.people,
            title: 'Inquiry',
          ),
          BarItem(
            icon: Icons.person,
            title: 'Distributor',
          ),
        ],
      ),
    );
  }
}
