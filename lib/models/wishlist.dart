import 'package:flutter/material.dart';
import 'package:shopping_cart_v2/models/shop_item.dart';

class Wishlist extends ChangeNotifier {
  List<ShopItem> wishlistCart = [];

  bool isInWishlist(ShopItem item) {
    return wishlistCart
        .any((wishListItem) => wishListItem.item.name == item.item.name);
  }

  void toggleWishlistItem(ShopItem item) {
    if (isInWishlist(item)) {
      removeItemFromWishList(item);
    } else {
      addItemToWishList(item);
    }
    notifyListeners();
  }

  void addItemToWishList(ShopItem item) {
    wishlistCart.add(item);
    print(wishlistCart.length);
    notifyListeners();
  }

  void removeItemFromWishList(ShopItem item) {
    wishlistCart.removeWhere(
        (wishlistItem) => wishlistItem.item.name == item.item.name);
    print(wishlistCart.length);
    notifyListeners();
  }
}
