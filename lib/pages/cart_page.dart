import 'package:flutter/material.dart';
import 'package:mad_proj/components/my_button.dart';
import 'package:mad_proj/models/product.dart';
import 'package:mad_proj/models/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  // remove item from cart method
  void removeItemFromCart(BuildContext context, Product product) {
    // show dialog box to ask user to confirm remove from cart action
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: const Text("Remove this item from your cart?"),
            actions: [
              // cancel button
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              // yes button
              MaterialButton(
                onPressed: () {
                  // pop dialog box
                  Navigator.pop(context);

                  // rmeove from cart
                  context.read<Shop>().removeFromCart(product);
                },
                child: Text("Yes"),
              ),
            ],
          ),
    );
  }

  // user pressed the pay button
  void payButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => const AlertDialog(
            content: Text("You have tapped the Pay button..."),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get access to the cart
    final cart = context.watch<Shop>().cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Cart Page"),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // cart list
          Expanded(
            child:
                cart.isEmpty
                    ? const Center(child: Text("Your cart is empty :("))
                    : ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        // get individual items in the cart
                        final item = cart[index];

                        // return as a cart tile UI
                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text(item.price.toStringAsFixed(2)),
                          trailing: IconButton(
                            onPressed: () => removeItemFromCart(context, item),
                            icon: const Icon(Icons.remove),
                          ),
                        );
                      },
                    ),
          ),
          // pay button
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: MyButton(
              onTap: () => payButtonPressed(context),
              child: Text("Pay Now"),
            ),
          ),
        ],
      ),
    );
  }
}
