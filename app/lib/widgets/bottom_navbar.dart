import 'package:app/screens/home.dart';
import 'package:app/screens/my_account.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/categories.dart';
import 'package:app/screens/new_arrival.dart';
import 'package:app/screens/cart.dart';

class CustomBottomNavBar extends StatefulWidget {
  final List<String> icons;
  final int initialIndex;

  const CustomBottomNavBar({
    Key? key,
    required this.icons,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) async {
    if (_selectedIndex != index && index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (_selectedIndex != index && index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CategoriesScreen()),
      );
    } else if (_selectedIndex != index && index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartScreen(),
        ),
      );
    } else if (_selectedIndex != index && index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyAccountScreen(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Color(0xFF292D32),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BottomNavigationBar(
            backgroundColor: Color(0xFF292D32),
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: widget.icons
                .asMap()
                .entries
                .map(
                  (entry) => BottomNavigationBarItem(
                    icon: Image.asset(
                      entry.value,
                      color: _selectedIndex == entry.key
                          ? Colors.blue
                          : Colors.grey,
                      height: 24,
                    ),
                    label: '',
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
