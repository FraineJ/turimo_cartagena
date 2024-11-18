import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {

  final IconData icon;
  final String title;
  final String description;


  const NoDataWidget({super.key, required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 75,
          ),
          Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight:FontWeight.bold
              ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
