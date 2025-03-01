import 'package:flutter/material.dart';
import './skeleton.dart';

class SkeletonCardBuys extends StatelessWidget {
  const SkeletonCardBuys({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: ListView.builder(
        itemCount: 10, // El número de veces que quieres repetir el card
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Skeleton(height: 160, width: double.infinity),
                SizedBox(height: 8),
                Skeleton(height: 10, width: double.infinity),
                SizedBox(height: 8),
                Skeleton(height: 20, width: double.infinity),
                SizedBox(height: 8),
                Skeleton(height: 10, width: double.infinity),
              ],
            ),
          );
        },
      ),
    );
  }
}
