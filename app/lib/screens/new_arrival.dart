import 'package:flutter/material.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:app/widgets/Arrivals/categories.dart';
import 'package:app/widgets/Arrivals/grid_items.dart';

class NewArrivalScreen extends StatefulWidget {
  @override
  _NewArrivalScreenState createState() => _NewArrivalScreenState();
}

class _NewArrivalScreenState extends State<NewArrivalScreen> {
  bool _isSearching = false;
  String _selectedSortOption = 'New Arrival';

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SortBottomSheet(
          selectedSortOption: _selectedSortOption,
          onSelect: (String option) {
            setState(() {
              _selectedSortOption = option;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Center(
            child: Text('Filter options go here'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C2C2C),
              Color(0xFF292D32),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                child: CustomHeader(
                  headerText: 'New Arrival',
                  rightWidget: IconButton(
                    icon: Icon(Icons.search, color: Colors.white, size: 28.0),
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                      });
                    },
                  ),
                ),
              ),
              CategorySelector(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 245),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NewArrivalGrid(
                                  numberOfRows: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: _showSortBottomSheet,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.sort,
                                          color: Color(0xFF292D32)),
                                      SizedBox(width: 8),
                                      Text(
                                        _selectedSortOption,
                                        style: TextStyle(
                                          color: Color(0xFF292D32),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: 1,
                                height: 24,
                                color: Color(0xFF292D32),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: _showFilterBottomSheet,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.filter_list,
                                          color: Color(0xFF292D32)),
                                      SizedBox(width: 8),
                                      Text(
                                        'Filter',
                                        style: TextStyle(
                                          color: Color(0xFF292D32),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SortBottomSheet extends StatelessWidget {
  final List<String> sortOptions = [
    'Price: High to Low',
    'Price: Low to High',
    'New Arrival',
    'Rating: High to Low'
  ];
  final String selectedSortOption;
  final Function(String) onSelect;

  SortBottomSheet({
    Key? key,
    required this.selectedSortOption,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Sort By',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sortOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sortOptions[index]),
                  trailing: selectedSortOption == sortOptions[index]
                      ? Icon(Icons.check_circle, color: Colors.black)
                      : null,
                  onTap: () {
                    onSelect(sortOptions[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
