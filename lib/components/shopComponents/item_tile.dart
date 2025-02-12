import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/components/custom/custom_image.dart';
import 'package:shopping_cart_v2/components/custom/custom_wishlist_icon.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:shopping_cart_v2/models/shop_item.dart';
import 'package:shopping_cart_v2/models/wishlist.dart';
import 'package:shopping_cart_v2/pages/item_page.dart';

class ItemTile extends StatefulWidget {
  final ShopItem product;
  final double imageHeight;
  final bool isShopPage;
  final double top;
  final double right;

  const ItemTile({
    super.key,
    required this.product,
    required this.imageHeight,
    required this.isShopPage,
    this.top = 0,
    this.right = 0,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
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
      child: Container(
        margin: EdgeInsets.all(8),
        width: 200,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     Color(0xFF4b68ff),
          //     Colors.white54.withOpacity(0.5),
          //     Color(0xFF4b68ff),
          //   ],
          // ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // item pic
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 300,
                    height: widget.isShopPage ? 90 : 70,
                    color: Colors.grey.shade200,
                    child: CustomImage.getImage(
                      widget.product.item.imagePath[0],
                      height: widget.imageHeight,
                    ),
                  ),
                ),

                // price + details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //show name
                    Text(
                      widget.product.item.name,
                      style: TextStyle(
                        fontSize: widget.isShopPage ? 17 : 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    //price
                    Text(
                      "\$${widget.product.item.price}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: widget.isShopPage ? 16 : 14,
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    //brand
                    Row(
                      children: [
                        Text(
                          widget.product.item.brand,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: widget.isShopPage ? 16 : 14,
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
                      height: 5,
                    ),

                    // rating
                    Row(
                      children: [
                        StarRating(
                          rating: double.parse(widget.product.item.rating),
                          allowHalfRating: true,
                          size: widget.isShopPage ? 20 : 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "(${widget.product.item.rating})",
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // wishlist icon
            CustomWishlistIcon(
              isWishListed:
                  context.watch<Wishlist>().isInWishlist(widget.product),
              onPressed: manageClickLove,
              top: widget.top,
              right: widget.right,
            ),
          ],
        ),
      ),
    );
  }
}
