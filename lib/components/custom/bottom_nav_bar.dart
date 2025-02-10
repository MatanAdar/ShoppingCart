import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBottomNavBar extends StatelessWidget {
  Function(int)? onTabChange;
  int selectedIndex;

  MyBottomNavBar(
      {super.key, required this.onTabChange, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 10),
      // child: GNav(
      //   color: Colors.grey[400],
      //   activeColor: Colors.grey.shade700,
      //   tabActiveBorder: Border.all(color: Colors.white),
      //   tabBackgroundColor: Colors.grey.shade100,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   tabBorderRadius: 16,
      //   gap: 6,
      //   onTabChange: (value) => onTabChange!(value),
      //   tabs: [
      //     GButton(
      //       icon: Icons.home,
      //       text: "Shop",
      //     ),
      //     GButton(
      //       icon: CupertinoIcons.heart,
      //       text: "Wishlist",
      //     ),
      //     GButton(
      //       icon: Icons.shopping_bag_rounded,
      //       text: "Cart",
      //     )
      //   ],
      // ),
      child: NavigationBar(
        onDestinationSelected: (value) => onTabChange!(value),
        selectedIndex: selectedIndex,
        height: 70,
        indicatorColor: Color(0xFF4b68ff).withOpacity(0.8),
        destinations: [
          NavigationDestination(
              icon: Icon(Icons.home_outlined), label: "H O M E"),
          NavigationDestination(
              icon: Icon(CupertinoIcons.heart), label: "W I S H L I S T"),
          NavigationDestination(
              icon: Icon(Icons.settings), label: "S E T T I N G S"),
          NavigationDestination(
              icon: Icon(CupertinoIcons.person), label: "P R O F I L E"),
        ],
      ),
    );
  }
}
