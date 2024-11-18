import 'package:flutter/material.dart';

class WidgetCategory extends StatelessWidget {
  final String title;
  final IconData iconData;
  const WidgetCategory({super.key,required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return _buildCategoryItem(title,  iconData);
  }
}

Widget _buildCategoryItem(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueAccent,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8.0),
        Flexible(child: Text(title, style: TextStyle(fontSize: 12))),
      ],
    ),
  );
}