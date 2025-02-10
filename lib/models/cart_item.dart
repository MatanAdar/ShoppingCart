import 'package:shopping_cart_v2/models/item.dart';

class CartItem {
  final Item item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});
}
