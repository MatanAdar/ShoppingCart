import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/components/shopComponents/cart_tile.dart';
import 'package:shopping_cart_v2/models/cart.dart';
import 'package:shopping_cart_v2/models/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<Cart>(
        builder: (context, cart, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title page
              Text(
                "My Cart",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.grey[800]),
              ),

              const SizedBox(
                height: 20,
              ),

              // list of my cart
              Expanded(
                child: ListView.builder(
                    itemCount: cart.getUserCart().length,
                    itemBuilder: (context, index) {
                      // get Each item
                      CartItem item = cart.getUserCart()[index];

                      // return the cart item
                      return CartTile(
                        product: item,
                      );
                    }),
              ),

              const SizedBox(
                height: 10,
              ),

              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFF4b68ff),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Checkout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "\$ ${cart.getPriceSum().toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              // Center(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.grey[100],
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              //     child: Text(
              //       cart.getPriceSum().toStringAsFixed(2),
              //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),

              // const SizedBox(
              //   height: 10,
              // ),

              // // pay Button
              // Container(
              //   height: 70,
              //   decoration: BoxDecoration(
              //     color: Colors.grey[900],
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Center(
              //     child: Text(
              //       "\$ PAY",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 16,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
