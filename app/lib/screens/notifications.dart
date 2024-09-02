import 'package:flutter/material.dart';
import 'package:app/widgets/custom_header.dart';
import 'package:app/widgets/Notifications/notifiaction_item.dart';

class NotificationScreen extends StatelessWidget {
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
                  headerText: 'Notifications',
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 245),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 32),
                      child: Column(
                        children: [
                          NotificationItem(
                            imageUrl: 'assets/Notification_icon.png',
                            message:
                                "We thought you’d like a new winter collections",
                            time: "3 days Ago",
                          ),
                          NotificationItem(
                            imageUrl: 'assets/Notification_icon.png',
                            message:
                                "We thought you’d like a new winter collections",
                            time: "3 days Ago",
                          ),
                          NotificationItem(
                            imageUrl: 'assets/Notification_icon.png',
                            message:
                                "We thought you’d like a new winter collections",
                            time: "3 days Ago",
                          ),
                        ],
                      ),
                    ),
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
