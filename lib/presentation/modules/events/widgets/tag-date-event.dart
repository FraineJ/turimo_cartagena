import 'package:flutter/material.dart';
import 'package:turismo_cartagena/core/theme/sizes.dart';

import '../../../../core/theme/colors.dart';



class DateTagEvent extends StatelessWidget {
  const DateTagEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal:  AppSizes.marginSmall,
            vertical: 4
        ),
        decoration:  BoxDecoration(
          color: AppColors.white,
          borderRadius:   BorderRadius.circular(AppSizes.marginSmall),
        ),
        child: Column(
          children: [
            Text("14",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: AppSizes.textLarge32,
              ),
              textAlign: TextAlign.center,
            ),
            Text("ENR",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: AppSizes.textMedium,
              ),
            )
          ],
        )
      ,
    );
  }
}
