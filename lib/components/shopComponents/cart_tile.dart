import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/components/custom/custom_dec_inc_container.dart';
import 'package:shopping_cart_v2/components/custom/custom_image.dart';
import 'package:shopping_cart_v2/controllers/amount_to_cart_controller.dart';
import 'package:shopping_cart_v2/models/cart.dart';
import 'package:shopping_cart_v2/models/cart_item.dart';

class CartTile extends StatefulWidget {
  CartItem product;
  CartTile({super.key, required this.product});

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  // controller to amount
  final AmountToCartController amountController =
      Get.put(AmountToCartController());

  // delete show from cart
  void removeFromCart() {
    Provider.of<Cart>(context, listen: false)
        .removeItemFromCart(widget.product.item);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(),
        ),
        margin: EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Row(
              children: [
                // image
                SizedBox(
                  width: 70,
                  child: CustomImage.getImage(
                    widget.product.item.imagePath[0],
                    height: 60,
                  ),
                ),

                // column of brand+name+amount
                SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.item.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      //brand
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.product.item.brand,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.verified,
                            size: 14,
                            color: Colors.blue[400],
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      CustomDecIncContainer(
                        incOnPressed: amountController.increment,
                        decOnPressed: amountController.decrement,
                        amountToCart: amountController.amountToCart,
                        cartItem: widget.product,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // column of delete icon and price
            Positioned(
              bottom: 0,
              right: 0,
              child: Text(
                "\$${widget.product.item.price}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
