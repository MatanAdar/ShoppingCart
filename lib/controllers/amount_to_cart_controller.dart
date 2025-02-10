import 'package:get/get.dart';

class AmountToCartController extends GetxController {
  var amountToCart = 0.obs;

  increment() => amountToCart++;

  decrement() => amountToCart--;

  void resetAmount() {
    amountToCart.value = 0;
  }
}
