import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/components/custom/bottom_nav_bar.dart';
import 'package:shopping_cart_v2/components/custom/custom_drawer.dart';
import 'package:shopping_cart_v2/models/cart.dart';
import 'package:shopping_cart_v2/pages/cart_page.dart';
import 'package:shopping_cart_v2/pages/profile_page.dart';
import 'package:shopping_cart_v2/pages/settings_page.dart';
import 'package:shopping_cart_v2/pages/shop_page.dart';
import 'package:shopping_cart_v2/pages/wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // To control the bottom nav bar
  int _selectedIndex = 0;

  // Change the selectedIndex when user tap on the nav bar
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // pages to display
  final List<Widget> _pages = [
    // shop page
    const ShopPage(),

    // wishlist page
    const WishlistPage(),

    // settings page
    const SettingsPage(),

    // profile page
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
        selectedIndex: _selectedIndex,
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF4b68ff),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.shopping_cart)),
              ),

              // container tells how much items in the cart
              Positioned(
                right: 7,
                top: 4,
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black.withOpacity(0.7),
                  ),
                  child: Center(
                    child: Text(
                      context.watch<Cart>().getAmountOfItemsInCart().toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: _pages[_selectedIndex],
    );
  }
}
