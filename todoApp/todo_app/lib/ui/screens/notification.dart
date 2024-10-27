import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/services/theme_service.dart';

import '../theme.dart';

class NotificationScreen extends StatelessWidget {
  final String payload;
  const NotificationScreen({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    final List<String> list = payload.split('|');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(list[0]),
        leading: IconButton(
          onPressed: () {
            //  Navigator.of(context).pop();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'Hello, Reem',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: ThemeService().theme == ThemeMode.dark
                  ? Colors.white
                  : darkGreyClr,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'You have a new reminder',
            style: TextStyle(
              color: Get.isDarkMode ? Colors.grey[100] : darkGreyClr,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: primaryClr),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildNotify(Icons.text_format, 'Title'),
                      Text(
                        list[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildNotify(Icons.description, 'Description'),
                      Text(
                        list[1],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildNotify(Icons.calendar_today_outlined, 'Date'),
                      Text(list[2],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                    ]),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Row buildNotify(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
