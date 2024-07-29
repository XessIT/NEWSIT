import 'package:flutter/material.dart';

import '../landing_page/custom_appbar.dart';
import '../theme/image_resource.dart';



class NotificationsScreen extends StatelessWidget {
  final List<NotificationItem> notificationsToday = [
    NotificationItem(
      title: "Your news have been Published",
      description: "Description",
      time: "Today",
      isBreakingNews: true,
      isRejected: false,
    ),
    NotificationItem(
      title: "Crypto investors should be",
      description: "Description",
      time: "Today",
      isBreakingNews: true,
      isRejected: false,
    ),
  ];

  final List<NotificationItem> notificationsYesterday = [
    NotificationItem(
      title: "Your news have been Published",
      description: "Your news have been Published",
      time: "Yesterday",
      isRejected: false,
    ),
    NotificationItem(
      title: "Your news have been Rejected",
      description: "Your news have been Published",
      time: "Yesterday",
      isRejected: true,
    ),
    NotificationItem(
      title: "Your news is in review",
      description: "Your news have been Published",
      time: "Yesterday",
      isInReview: true,
    ),
    NotificationItem(
      title: "Your news have been Published",
      description: "Your news have been Published",
      time: "Yesterday",
      isRejected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LeadingApp(title:"Notification",),
      body: ListView(
        children: [
          SizedBox(height: 10),

          SectionHeading(title: "Today"),
          ...notificationsToday
              .map((notification) =>
                  NotificationTile(notification: notification))
              .toList(),
          SectionHeading(title: "Yesterday"),
          ...notificationsYesterday
              .map((notification) =>
                  NotificationTile(notification: notification))
              .toList(),
        ],
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;

  SectionHeading({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  NotificationTile({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xffF5F4F9),
        borderRadius: BorderRadius.circular(16),
        border: Border(
          right: BorderSide(
            color: notification.isRejected
                ? Colors.red
                : notification.isInReview
                    ? Colors.amber
                    : Colors.green,
            width: 7,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: Image.asset(
                  ImageResource.splashlogo), // Replace with your image asset
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    notification.description,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (notification.isBreakingNews)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'BREAKING NEWS',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                SizedBox(height: 4),
                // Text(notification.time,
                //     style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final bool isBreakingNews;
  final bool isRejected;
  final bool isInReview;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    this.isBreakingNews = false,
    this.isRejected = false,
    this.isInReview = false,
  });
}
