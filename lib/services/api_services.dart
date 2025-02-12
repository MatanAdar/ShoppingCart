import 'dart:convert';

import 'package:shopping_cart_v2/models/item.dart';
import 'package:shopping_cart_v2/models/shop_item.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<ShopItem>> fetchItemsData() async {
    try {
      // get all Items
      final getAllUri = Uri.parse(
          "https://dummyjson.com/products?limit=0&skip=0&select=title,price,description,category,rating,images,brand,stock");
      final allItemsResponse = await http.get(getAllUri);

      if (allItemsResponse.statusCode == 200) {
        return getProductsToList(jsonDecode(allItemsResponse.body));
      } else {
        // Handle non-200 status code
        print("Error: HTTP ${allItemsResponse.statusCode}");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  List<ShopItem> getProductsToList(dynamic responseBody) {
    return responseBody["products"]
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
        .toList()
      ..sort((a, b) =>
          double.parse(b.item.rating).compareTo(double.parse(a.item.rating)));
  }

  Future<List<String>> fetchCategories() async {
    try {
      // get the categories
      final uri = Uri.parse('https://dummyjson.com/products/category-list');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return getCategoriesToList(jsonDecode(response.body));
      } else {
        // Handle non-200 status code
        print("Error: HTTP ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  List<String> getCategoriesToList(dynamic responseBody) {
    return List<String>.from(responseBody);
  }
}
