import 'package:flutter/material.dart';
import 'package:turismo_cartagena/core/theme/sizes.dart';
import 'package:turismo_cartagena/generated/l10n.dart';

import '../../../../core/theme/colors.dart';

class LoginOrBar extends StatelessWidget {
  final double stock;
  const LoginOrBar({super.key, this.stock = 1});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: 20,
            color: AppColors.transparentColor),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                //  margin: const EdgeInsets.symmetric(horizontal: Dimensions.space50),
                width: AppSizes.screenWidth,
                height: stock,
                color: AppColors.borderColor,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 40,
                color: AppColors.white,
                child: Center(
                  child: Text(S.current.or,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.primaryTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizes.textMedium
                    ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
