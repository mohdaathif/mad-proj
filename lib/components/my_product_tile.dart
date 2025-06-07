import 'package:flutter/material.dart';
import 'package:mad_proj/models/product.dart';
import 'package:mad_proj/models/shop.dart';
import 'package:provider/provider.dart';

class MyProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap; // optional tap callback for navigation

  const MyProductTile({super.key, required this.product, this.onTap});

  // add to cart button pressed
  void addToCart(BuildContext context) {
    // show dialog box to ask user to confirm add to cart action
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Text("Add this item to your cart?"),
            actions: [
              // cancel button
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              // yes button
              MaterialButton(
                onPressed: () {
                  // pop dialog box
                  Navigator.pop(context);

                  // add to cart
                  context.read<Shop>().addToCart(product);
                },
                child: Text("Yes"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // allows ripple effect to show properly
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap, // triggers navigation to details screen
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(25),
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // product image
                  AspectRatio(
                    aspectRatio: 1, // meaning its a square
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: double.infinity, // means fill up the entire width
                      padding: const EdgeInsets.all(
                        25,
                      ), // const tells Flutter to compile the object once at build time and reuse it instead of creating a new one each time the widget rebuilds
                      child: Image.asset(product.imagePath),
                    ), // without const, Flutter would create a new object in memory every time the widget is rebuilt — even if the values are the same
                  ), // so adding const basically improves performance and optimizes memory usage

                  const SizedBox(height: 25),

                  // product name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // product description
                  Text(
                    product.description,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // product price & add to cart button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // product price
                  Text('\$' + product.price.toStringAsFixed(2)),

                  // add to cart button
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.scrim,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => addToCart(context),
                      icon: Icon(Icons.add),
                    ),
                  ),
                ],
              ), // double converted to string as 2 dp
            ],
          ),
        ),
      ),
    );
  }
}
