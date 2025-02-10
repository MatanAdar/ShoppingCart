import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_v2/components/custom/custom_circle_header_container.dart';
import 'package:shopping_cart_v2/components/shopComponents/item_tile.dart';
import 'package:shopping_cart_v2/models/cart.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shopping_cart_v2/models/shop_item.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // controller to control the input in search bar
  TextEditingController _controller = TextEditingController();

  void searchItemFunction(String query) {
    context.read<Cart>().searchItem(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Cart>(
        builder: (context, value, child) => Column(
          children: [
            // Static header section
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Color(0xFF4b68ff),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(),
                ],
              ),
              child: SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: -70,
                      right: 270,
                      child: CirclueHeaderContainer(
                        backgroundColor: Colors.white54.withOpacity(0.1),
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Positioned(
                      bottom: -70,
                      right: -30,
                      child: CirclueHeaderContainer(
                        backgroundColor: Colors.white54.withOpacity(0.1),
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Column(
                      children: [
                        // Search Bar
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: _controller,
                              onChanged: (query) => searchItemFunction(query),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Search",
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                        ),

                        // Message
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                              "Everyone flies... some fly longer than others",
                              style: TextStyle(color: Colors.grey[800])),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hot Picks header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Hot picks 🔥",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "See all",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Hot Picks list
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: value.get10HighestRatedItems().length,
                        itemBuilder: (context, index) {
                          ShopItem product =
                              value.get10HighestRatedItems()[index];
                          return ItemTile(
                            product: product,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Categories list
                    SizedBox(
                      height:
                          value.categories.length * 285, // Height per category
                      child: GroupedListView<String, String>(
                        elements: value.categories,
                        groupBy: (element) =>
                            element[0].toUpperCase() + element.substring(1),
                        groupSeparatorBuilder: (String groupByValue) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Text(
                            groupByValue,
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        indexedItemBuilder: (context, element, index) {
                          final categoryItems = value
                              .getSearchItemsShop()
                              .where(
                                  (product) => product.item.category == element)
                              .toList();

                          return SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryItems.length,
                              itemBuilder: (context, index) {
                                final product = categoryItems[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ItemTile(
                                    product: product,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
