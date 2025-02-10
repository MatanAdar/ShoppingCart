import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/components/shopComponents/item_tile.dart';
import 'package:shopping_cart_v2/models/wishlist.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Wishlist>(
        builder: (context, wishlist, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wishlist title
              Text(
                "Wishlist",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: "Poppins",
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    context.read<Wishlist>().wishlistCart.length,
                    (index) {
                      final wishlistItem = wishlist.wishlistCart[index];
                      return ItemTile(product: wishlistItem);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
