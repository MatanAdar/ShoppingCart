import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_cart_v2/models/cart_item.dart';
import 'package:shopping_cart_v2/models/item.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_v2/models/shop_item.dart';

class Cart extends ChangeNotifier {
  // Categroy List
  List<String> categories = [];

  // Shop invertory
  List<ShopItem> shopInventory = [
    ShopItem(
      item: Item(
        name: "Zoom Freak",
        price: "236",
        description: "The foward-thinking design of his latest signature shoe.",
        imagePath: ["lib/images/zoom-freak-1.png"],
        rating: "4.5",
        category: "men's-shoes",
        brand: "Nike",
      ),
      stock: Random().nextInt(10),
    ),
    ShopItem(
      item: Item(
        name: "Air Jordan",
        price: "220",
        description:
            "This fresh take on the AJ1 brings new energy to a classic neutral colourway. Smooth, premium leather and Nike Air cushioning give you the quality and comfort you've come to expect from Jordan.",
        imagePath: ["lib/images/air-jordan-chicago.png"],
        rating: "4.5",
        category: "men's-shoes",
        brand: "Nike",
      ),
      stock: Random().nextInt(10),
    ),
    ShopItem(
      item: Item(
        name: "KD Treys",
        price: "240",
        description:
            "While Kevin Durant's all-timer status is already cemented, his hooper soul can't be soothed unless he's on the court, perfecting his craft. Put in the work to be great in the KD17, a shoe for gym rats and those who insist on running it back. A forefoot Air Zoom unit enhances your first step. We combined it with Nike Air cushioning to fuel full-court sprints and defensive stops that can decide games.",
        imagePath: ["lib/images/KDTREY.png"],
        rating: "4.5",
        category: "men's-shoes",
        brand: "Nike",
      ),
      stock: Random().nextInt(10),
    ),
    ShopItem(
      item: Item(
        name: "kyrie-7",
        price: "190",
        description:
            "The Nike Kyrie 7 EP Icons of Sport salutes the heroes, mentors and influences that shaped Kyrie Irving’s game. A bold crimson finish throughout the mesh upper and midsole give the nod to Michael Jordan, while hints of purple and gold on the textile underlay pays tribute to Kobe Bryant. Royal blue accents point to Kyrie’s tutelage under Coach K at Duke University. On the heel overlay, an embroidered clipboard graphic references Irving’s game-winning shot from the 2016 NBA championship. The multi-color outsole features extra-durable rubber designed for play on outdoor courts.",
        imagePath: ["lib/images/kyrie-7.png"],
        rating: "4.5",
        category: "men's-shoes",
        brand: "Nike",
      ),
      stock: Random().nextInt(10),
    ),
  ];

  double priceSum = 0;

  Future<void> fetchItemsData() async {
    try {
      // get the categories
      final uri = Uri.parse('https://dummyjson.com/products/category-list');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        data.forEach((category) => {
              categories.add(category.toString()),
            });
      }
      // get all Items
      final getAllUri = Uri.parse(
          "https://dummyjson.com/products?limit=0&skip=0&select=title,price,description,category,rating,images,brand,stock");
      final allItemsResponse = await http.get(getAllUri);

      if (allItemsResponse.statusCode == 200) {
        final allItemsData = jsonDecode(allItemsResponse.body)["products"];

        shopInventory = allItemsData
            .map<ShopItem>(
              (item) => ShopItem(
                item: Item(
                  name: item["title"],
                  price: item["price"].toString(),
                  imagePath: item["images"],
                  description: item["description"],
                  rating: item["rating"].toString(),
                  category: item["category"],
                  brand: item["brand"] ?? "Amazon",
                ),
                stock: item["stock"],
              ),
            )
            .toList();
      }

      shopInventory.sort((a, b) =>
          double.parse(b.item.rating).compareTo(double.parse(a.item.rating)));
      searchItemsShop = shopInventory;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<ShopItem> searchItemsShop = [];

  // list of items in user cart
  List<CartItem> userCart = [];

  List<ShopItem> getFullItems() {
    return shopInventory;
  }

  List<ShopItem> getSearchItemsShop() {
    return searchItemsShop;
  }

  List<ShopItem> get10HighestRatedItems() {
    int itemsToTake =
        searchItemsShop.length <= 10 ? searchItemsShop.length : 10;
    return searchItemsShop.sublist(0, itemsToTake);
  }

  void searchItem(String query) {
    if (query.isEmpty) {
      searchItemsShop = getFullItems();
    } else {
      List<ShopItem> templist = [];

      shopInventory.forEach(
        (product) {
          if (product.item.name.toLowerCase().contains(query.toLowerCase())) {
            templist.add(product);
          }
        },
      );

      searchItemsShop = templist;
      notifyListeners();
    }
  }

  void modifyItemsShopList() {
    searchItemsShop = shopInventory;
  }

  // get cart
  List<CartItem> getUserCart() {
    return userCart;
  }

  int getAmountOfItemsInCart() {
    int amount = 0;
    userCart.forEach(
      (product) => amount += product.quantity,
    );
    print(amount);
    return amount;
  }

  double getPriceSum() {
    return priceSum;
  }

  // add items to cart
  void addItemToCart(Item item, {int addAmount = 1}) {
    final findExistingItemInCart = userCart.firstWhere(
        (cartProduct) => cartProduct.item.name == item.name,
        orElse: () => CartItem(item: item, quantity: 0));

    if (findExistingItemInCart.quantity == 0) {
      userCart.add(CartItem(item: item, quantity: addAmount));
      print("Added new ${item.name} with quantity of: ${addAmount}");
    } else {
      findExistingItemInCart.quantity += addAmount;
      print("Added to the ${item.name} quantity of: ${addAmount}");
    }

    // Update stock
    final findShopItem =
        searchItemsShop.firstWhere((product) => product.item.name == item.name);

    findShopItem.stock -= addAmount;
    print(
        "The stack amount of ${findShopItem.item.name} is: ${findShopItem.stock}");

    priceSum += double.parse(item.price) * addAmount;
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(Item item) {
    final cartItem = userCart.firstWhere(
      (cartItem) => cartItem.item.name == item.name,
    );

    if (cartItem.quantity > 1) {
      // If quantity > 1, just decrease quantity
      cartItem.quantity--;
    } else {
      // If quantity = 1, remove item from cart
      userCart.remove(cartItem);
    }

    // Update stock
    final shopItem = shopInventory.firstWhere(
      (shopItem) => shopItem.item.name == item.name,
    );
    shopItem.stock++;

    priceSum -= double.parse(item.price);

    notifyListeners();
  }
}
