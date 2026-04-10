import 'package:flutter/material.dart';
import 'package:kesak_fe/app/home/home.dart';

class ButtomBar extends StatefulWidget {
  const ButtomBar({super.key});

  @override
  State<ButtomBar> createState() => _ButtomBarState();
}

class _ButtomBarState extends State<ButtomBar> {
  int selected = 0;
  
  Widget _buildBody() {
    switch (selected) {
      case 0:
        return const Home();
      case 1:
        return const Center(
          child: Placeholder(
            fallbackHeight: 200,
            fallbackWidth: 200,
          ),
        );
      case 2:
        return const Center(
          child: Placeholder(
            fallbackHeight: 200,
            fallbackWidth: 200,
          ),
        );
      case 3:
        return const Center(
          child: Placeholder(
            fallbackHeight: 200,
            fallbackWidth: 200,
          ),
        );
      default:
        return const Home();
    }
  }
  
  void onItemTapped(int index) {
    setState(() {
      selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: 'QRIS',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Payment'),
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: 'Scan'),
        ],
        currentIndex: selected,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}
