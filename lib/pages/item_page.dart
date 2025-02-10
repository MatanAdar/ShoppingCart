import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/components/custom/custom_dec_inc_container.dart';
import 'package:shopping_cart_v2/components/custom/custom_wishlist_icon.dart';
import 'package:shopping_cart_v2/controllers/amount_to_cart_controller.dart';
import 'package:shopping_cart_v2/models/cart.dart';
import 'package:shopping_cart_v2/models/item.dart';
import 'package:shopping_cart_v2/models/shop_item.dart';

class ItemPage extends StatefulWidget {
  final ShopItem product;
  final bool isWishListed;
  void Function()? onPressed;
  ItemPage(
      {super.key,
      required this.product,
      required this.isWishListed,
      required this.onPressed});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  int selectedIndex = 0;

  final AmountToCartController amountController =
      Get.put(AmountToCartController());

  Widget getImage(String path, double height) {
    return path.startsWith('http') || path.startsWith('https')
        ? Image.network(
            path,
            height: height,
          )
        : Image.asset(
            path,
            height: height,
          );
  }

  // Add item to the cart
  void addItemToCart(Item item, int addAmountToCart) {
    // Get the object (Cart) to use the function
    context.read<Cart>().addItemToCart(item, addAmount: addAmountToCart);

    // Reset the amount controller
    amountController.resetAmount();

    // Alert user the item successfuly added to the cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Successfuly added to the cart"),
        content: Text("Check your cart!"),
      ),
    );

    context.read<Cart>().modifyItemsShopList();

    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Detail"),
        centerTitle: true,
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) => Column(
          children: [
            // item image
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: getImage(
                      widget.product.item.imagePath[selectedIndex], 250),
                ),
                CustomWishlistIcon(
                    top: 10,
                    right: 10,
                    isWishListed: widget.isWishListed,
                    onPressed: widget.onPressed),
              ],
            ),

            // all images of the product
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.item.imagePath.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            getImage(widget.product.item.imagePath[index], 80),
                      ),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // stars with amount of stars text
                      Row(
                        children: [
                          StarRating(
                            rating: double.parse(widget.product.item.rating),
                            allowHalfRating: true,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(widget.product.item.rating),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // price
                      Text(
                        "\$${widget.product.item.price}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // item name
                      Text(
                        widget.product.item.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // in stock
                      Row(
                        children: [
                          Text(
                            "Stock: ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.product.stock.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // brand
                      Row(
                        children: [
                          Text(
                            "Brand: ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.product.item.brand,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // description
                      Text(
                        widget.product.item.description,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                        ),
                      ),

                      // color

                      // size

                      Spacer(),

                      // button add to cart
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10),
                        child: Row(
                          children: [
                            // decrease button
                            CustomDecIncContainer(
                              incOnPressed: amountController.increment,
                              decOnPressed: amountController.decrement,
                              amountToCart: amountController.amountToCart,
                            ),

                            Spacer(),

                            // Add to cart button
                            Obx(
                              () => GestureDetector(
                                onTap: amountController.amountToCart.value == 0
                                    ? null
                                    : () {
                                        addItemToCart(
                                          widget.product.item,
                                          amountController.amountToCart.value,
                                        );
                                      },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        amountController.amountToCart.value == 0
                                            ? Colors.grey.shade500
                                            : Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      // icon
                                      Icon(
                                        CupertinoIcons.bag,
                                        color: Colors.white,
                                      ),

                                      SizedBox(
                                        width: 10,
                                      ),
                                      // text
                                      Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // const Spacer(),

            // // button add to cart
            // GestureDetector(
            //   onTap: widget.onTap,
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 25),
            //     height: 45,
            //     decoration: BoxDecoration(
            //       color: Colors.grey[900],
            //       borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(12),
            //           topRight: Radius.circular(12)),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.add,
            //           color: Colors.white,
            //         ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         Text(
            //           "Add to cart",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 20),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // const SizedBox(
            //   height: 25,
            // ),
          ],
        ),
      ),
    );
  }
}
