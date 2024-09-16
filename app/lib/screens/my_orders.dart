import 'package:app/constants/constants.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/Orders/order_item.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  String _selectedFilterOption = 'Price: High to Low';

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FilterBottomSheet(
          selectedSortOption: _selectedFilterOption,
          onSelect: (String option) {
            setState(() {
              _selectedFilterOption = option;
            });
            Navigator.pop(context);
          },
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
                child: CustomHeader(headerText: 'Your orders'),
              ),
              Expanded(
                child: Container(
                  color: Color.fromARGB(255, 230, 230, 230),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 2.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search all your orders',
                                    hintStyle:
                                        AppConstants.normalTextStyle.copyWith(
                                      color: Color(0xFFB3B3B3),
                                    ),
                                    prefixIcon: Icon(Icons.search),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed:
                                  _showFilterBottomSheet, // Call the method here
                              child: Row(
                                children: [
                                  Text('Filter',
                                      style: AppConstants.normalTextStyle),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 24, horizontal: 16),
                            child: Column(
                              children: [
                                OrderItem(
                                  orderNumber: 'A255DSD5FF',
                                  price: '\25000 SAR',
                                  orderDate: ' Aug 23 , 2022',
                                  itemName: 'Elegent Blazer',
                                  isDelivered: true,
                                  onWriteReview: () {
                                    print('Write review for Order 12345');
                                  },
                                ),
                                OrderItem(
                                  orderNumber: '12346',
                                  price: '\25040 SAR',
                                  orderDate: 'Aug 23 , 2012',
                                  itemName: 'Elegent Blazer',
                                  isDelivered: false,
                                  onWriteReview: () {
                                    print('Write review for Order 12346');
                                  },
                                ),
                                OrderItem(
                                  orderNumber: '12347',
                                  price: '\$20.00',
                                  orderDate: 'Aug 23 , 2012',
                                  itemName: 'Elegent Blazer',
                                  isDelivered: true,
                                  onWriteReview: () {
                                    print('Write review for Order 12347');
                                  },
                                ),
                              ],
                            ),
                          ),
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

class FilterBottomSheet extends StatelessWidget {
  final List<String> sortOptions = [
    'This Month',
    'Last 6 months',
    'Last Year',
    'Last Decade'
  ];
  final String selectedSortOption;
  final Function(String) onSelect;

  FilterBottomSheet({
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
              'Filter Orders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sortOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  title: Text(sortOptions[index], textAlign: TextAlign.left),
                  trailing: selectedSortOption == sortOptions[index]
                      ? Icon(
                          Icons.check_circle,
                          color: Color(0xFF33CCCC),
                        )
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
