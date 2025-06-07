import 'package:flutter/material.dart';
import 'package:mad_proj/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer header: logo
              DrawerHeader(
                child: Icon(
                  Icons.fitness_center_rounded,
                  size: 72,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),

              const SizedBox(height: 25),

              // shop tile
              MyListTile(
                text: "Shop",
                icon: Icons.storefront_rounded,
                onTap:
                    () => Navigator.pop(
                      context,
                    ), // already on shop so just close drawer
              ),
              // cart tile
              MyListTile(
                text: "Cart",
                icon: Icons.shopping_cart,
                onTap: () {
                  Navigator.pop(context); // pop drawer first
                  Navigator.pushNamed(context, '/cart_page');
                }, // then go to cart page
              ),
            ],
          ),
          // exit tile
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              text: "Exit",
              icon: Icons.exit_to_app,
              onTap: () => Navigator.pushNamed(context, '/home_page'),
            ),
          ),
        ],
      ),
    );
  }
}
