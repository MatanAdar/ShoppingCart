import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/components/custom/custom_wishlist_icon.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:shopping_cart_v2/models/shop_item.dart';
import 'package:shopping_cart_v2/models/wishlist.dart';
import 'package:shopping_cart_v2/pages/item_page.dart';

class ItemTile extends StatefulWidget {
  ShopItem product;
  ItemTile({super.key, required this.product});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  Widget getImage(String path) {
    return path.startsWith('http') || path.startsWith('https')
        ? Image.network(
            path,
            height: 100,
          )
        : Image.asset(
            path,
            height: 100,
          );
  }

  void manageClickLove() {
    context.read<Wishlist>().toggleWishlistItem(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ItemPage(
                product: widget.product,
                isWishListed:
                    context.watch<Wishlist>().isInWishlist(widget.product),
                onPressed: manageClickLove,
              ))),
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            width: 220,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // item pic
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: getImage(
                        widget.product.item.imagePath[0],
                      ),
                    ),

                    // rating
                    StarRating(
                      rating: double.parse(widget.product.item.rating),
                      allowHalfRating: true,
                    ),

                    // price + details
                    Column(
                      children: [
                        //show name
                        Text(
                          widget.product.item.name,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        //price
                        Text("\$${widget.product.item.price}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ],
                ),
                CustomWishlistIcon(
                    isWishListed:
                        context.watch<Wishlist>().isInWishlist(widget.product),
                    onPressed: manageClickLove),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
