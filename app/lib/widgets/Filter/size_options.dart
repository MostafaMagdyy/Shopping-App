import 'package:app/constants/constants.dart';
import 'package:app/widgets/Components/basic_header.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/button.dart';

class SizeOptions extends StatefulWidget {
  const SizeOptions({Key? key}) : super(key: key);

  @override
  _SizeOptionsState createState() => _SizeOptionsState();
}

class _SizeOptionsState extends State<SizeOptions> {
  final List<int> sizeOptions = [36, 37, 38, 39, 40, 41];
  List<int> selectedSizes = [];

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
                child: BasicHeader(
                  headerText: 'Filter',
                  rightWidget: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel',
                        style: AppConstants.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 230, 230, 230),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: sizeOptions.length,
                          itemBuilder: (context, index) {
                            return _buildSizeItem(sizeOptions[index]);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: CustomButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'Apply',
                          backgroundColor: Color(0xFF292D32),
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

  Widget _buildSizeItem(int size) {
    bool isSelected = selectedSizes.contains(size);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFFE9E8E8),
            width: 1.0,
          ),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Size $size',
            style: AppConstants.normalTextStyle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  selectedSizes.remove(size);
                } else {
                  selectedSizes.add(size);
                }
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF33CCCC)),
                borderRadius: BorderRadius.circular(4),
                color: isSelected ? Color(0xFF33CCCC) : Colors.white,
              ),
              child: isSelected
                  ? Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
