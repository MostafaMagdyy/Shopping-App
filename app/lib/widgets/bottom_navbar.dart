import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final List<String> icons;

  const CustomBottomNavBar({
    Key? key,
    required this.icons,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
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
                  color:
                      _selectedIndex == entry.key ? Colors.blue : Colors.grey,
                  height: 24,
                ),
                label: '',
              ),
            )
            .toList(),
      ),
    );
  }
}
