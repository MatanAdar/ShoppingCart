import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/models/cart.dart';
import 'package:shopping_cart_v2/models/cart_item.dart';

class CustomDecIncContainer extends StatelessWidget {
  void Function()? incOnPressed;
  void Function()? decOnPressed;
  RxInt amountToCart;
  CartItem? cartItem;

  CustomDecIncContainer({
    super.key,
    required this.incOnPressed,
    required this.decOnPressed,
    required this.amountToCart,
    this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return cartItem == null
        ? Obx(
            () => Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: amountToCart.value == 0
                        ? Colors.grey.shade500
                        : Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: amountToCart.value == 0 ? null : decOnPressed,
                    icon: Icon(
                      Icons.remove,
                    ),
                    color: Colors.white,
                  ),
                ),

                SizedBox(
                  width: 15,
                ),

                // amount add to cart

                Text(
                  amountToCart.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(
                  width: 15,
                ),

                // increase amount to cart
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: incOnPressed,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: cartItem!.quantity == 0
                      ? Colors.grey.shade500
                      : Color(0xFF4b68ff),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () =>
                      context.read<Cart>().removeItemFromCart(cartItem!.item),
                  icon: Icon(
                    Icons.remove,
                  ),
                  color: Colors.white,
                ),
              ),

              SizedBox(
                width: 15,
              ),

              // amount add to cart

              Text(
                cartItem!.quantity.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(
                width: 15,
              ),

              // increase amount to cart
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4b68ff),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () =>
                      context.read<Cart>().addItemToCart(cartItem!.item),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
  }
}
