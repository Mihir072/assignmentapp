import 'package:assingmentapp/bloc/cart_bloc.dart';
import 'package:assingmentapp/pages/card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/home_page.dart';
import '../util/colors.dart';

class BottomBarWidget extends StatefulWidget {
  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      BlocProvider.value(
        value: context.read<CartBloc>(),
        child: CartPage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: mainColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart')
        ],
      ),
    );
  }
}
