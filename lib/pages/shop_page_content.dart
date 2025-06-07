import 'package:flutter/material.dart';
import 'package:mad_proj/components/my_product_tile.dart';
import 'package:mad_proj/models/shop.dart';
import 'package:mad_proj/pages/product_detail_page.dart';
import 'package:provider/provider.dart';

class ShopPageContent extends StatelessWidget {
  const ShopPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    // access products in the shop
    final products =
        context
            .watch<
              Shop
            >() // .watch <Shop>() -> give the Shop object and re-build this widget if it changes
            .shop; // .shop -> gets the product list because .shop is the getter in our Shop class that returns the list of products

    return ListView(
      children: [
        const SizedBox(height: 25),
        // shop subtitle
        Center(
          child: Text(
            "Pick from a selected list of premium products.",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),

        // product list
        SizedBox(
          height: 550,
          child: ListView.builder(
            //builds the product list dynamically
            itemCount: products.length,
            padding: const EdgeInsets.all(15),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              // get each individual product from the shop
              final product = products[index];

              // return as a product tile UI
              return MyProductTile(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
              ); // displays each product visually
            },
          ),
        ),
      ],
    );
  }
}
