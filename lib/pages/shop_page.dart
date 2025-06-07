import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mad_proj/components/my_drawer.dart';
import 'package:mad_proj/pages/accelerometer_activity_page.dart';
import 'package:mad_proj/pages/connectivity_page.dart';
import 'package:mad_proj/pages/location_page.dart';
import 'package:mad_proj/pages/shop_page_content.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _selectedIndex = 0;

  // pages list for IndexedStack
  final List<Widget> _pages = [
    ShopPageContent(),
    ConnectivityPage(),
    ActivityDetectionPage(),
    LocationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // access products in the shop
    // final products = context.watch<Shop>().shop;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.primary,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(
            Icons.storefront_rounded,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          Icon(
            Icons.info_outline,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          Icon(
            Icons.directions_run,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          Icon(
            Icons.navigation_rounded,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ],
        onTap: _onItemTapped,
      ),
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? "Shop"
              : _selectedIndex == 1
              ? "    Device Utilities"
              : _selectedIndex == 2
              ? "    Accelerometer Motion Sensor"
              : "    Location Tracking",
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions:
            _selectedIndex == 0
                ? [
                  // go to cart button
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/cart_page'),
                    icon: Icon(Icons.shopping_cart_outlined),
                  ),
                ]
                : null,
      ),
      drawer: _selectedIndex == 0 ? MyDrawer() : null,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}
