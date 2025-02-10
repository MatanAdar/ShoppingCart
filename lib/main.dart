import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/models/cart.dart';
import 'package:shopping_cart_v2/models/wishlist.dart';
import 'package:shopping_cart_v2/pages/intro_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get/get.dart';

void main() {
  runApp(DevicePreview(builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Cart()..fetchItemsData(),
        ),
        ChangeNotifierProvider(
          create: (context) => Wishlist(),
        ),
      ],
      builder: (context, index) => const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
      ),
    );
  }
}
