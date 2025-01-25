import 'package:flutter/material.dart';
import './skeleton.dart';

class SkeletonCardBuys extends StatelessWidget {
  const SkeletonCardBuys({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: EdgeInsets.all(8.0),
      child:  Column(
        children:  [
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
  }
}