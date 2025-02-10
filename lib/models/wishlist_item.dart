import 'package:shopping_cart_v2/models/item.dart';

class WishlistItem {
  final Item item;
  bool isWishlisted;

  WishlistItem({required this.item, this.isWishlisted = false});
}
