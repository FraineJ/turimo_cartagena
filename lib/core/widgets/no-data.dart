import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turismo_cartagena/core/theme/sizes.dart';

import '../theme/colors.dart';

class NoDataWidget extends StatelessWidget {
  final String svgPath; // Dirección de la imagen SVG
  final String title;
  final String description;
  bool network;

  NoDataWidget({
    super.key,
    required this.svgPath,
    required this.title,
    required this.description,
    this.network = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        network ? SvgPicture.network(
          svgPath,
          width: 75,
          height: 75,
        )
        : SvgPicture.asset(
          svgPath,
          width: 75,
          height: 75,
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSizes.textMedium,
            color: AppColors.textSecondary
          ),
        ),
      ],
    );
  }
}
