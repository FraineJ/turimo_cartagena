import 'package:flutter/material.dart';

class AlertScreenPopup extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final List<Widget> actions;

  const AlertScreenPopup({
    Key? key,
    required this.title,
    required this.message,
    this.icon = Icons.warning_amber_rounded,
    this.iconColor = Colors.amber,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: iconColor,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: actions.isNotEmpty
                  ? actions
                  : [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("OK"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
