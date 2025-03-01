import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../generated/l10n.dart';
import '../theme/colors.dart';
import '../theme/sizes.dart';

class CustomSnackBar {

  static String removeQuotationAndSpecialCharacterFromString(String value) {
    try {
      String formatedString =
      value.replaceAll('"', '').replaceAll('[', '').replaceAll(']', '');
      return formatedString;
    } catch (e) {
      return value;
    }
  }
  
  static error(
      {required List<String> errorList,
      int duration = 5,
      SnackPosition position = SnackPosition.TOP}) {
    if (errorList.isEmpty) {
      errorList = [ S.current.somethingWentWrong.tr];
    }

    for (var i = 0; i < errorList.length; i++) {
      String message = removeQuotationAndSpecialCharacterFromString(
          errorList[i].tr);
      Future.delayed(Duration(microseconds: 1000 * (i + 1)), () {
        if (Get.context == null) {
          Get.closeAllSnackbars();
          Get.rawSnackbar(
            progressIndicatorBackgroundColor: AppColors.transparentColor,
            progressIndicatorValueColor:
                const AlwaysStoppedAnimation<Color>(Colors.transparent),
            messageText: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  Icon(Icons.error, color: AppColors.error, size: 24)
                      .animate(
                          onComplete: (controller) => controller.repeat(
                              reverse: true,
                              period: const Duration(seconds: 1)))
                      .scale(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut),
                  SizedBox(width: AppSizes.marginSmall),
                  Expanded(
                    child: Text(message.tr,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizes.textMedium
                        ).copyWith(
                            color: AppColors.error
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            dismissDirection: DismissDirection.horizontal,
            snackPosition: position,
            backgroundColor: AppColors.error,
            borderRadius: 4,
            margin:  EdgeInsets.all(AppSizes.marginSmall),
            padding:  EdgeInsets.all(AppSizes.marginSmall),
            duration: Duration(seconds: duration),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeIn,
            showProgressIndicator: true,
            leftBarIndicatorColor: AppColors.transparentColor,
            animationDuration: const Duration(seconds: 1),
            borderColor: AppColors.transparentColor,
            reverseAnimationCurve: Curves.easeOut,
            borderWidth: 2,
          );
        } else {
          Flushbar(
            messageText: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  Icon(Icons.error, color: AppColors.error, size: 24)
                      .animate(
                          onComplete: (controller) => controller.repeat(
                              reverse: true,
                              period: const Duration(seconds: 1)))
                      .scale(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut),
                  SizedBox(width: AppSizes.marginSmall),
                  Expanded(
                    child: Text(message.tr,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizes.textMedium
                        ).copyWith(
                            color: AppColors.error),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            margin:  EdgeInsets.all(AppSizes.marginSmall),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMedium),
            backgroundColor: AppColors.white,
            duration: Duration(seconds: duration + (i + 1)),
            leftBarIndicatorColor: AppColors.error,
            forwardAnimationCurve: Curves.fastEaseInToSlowEaseOut,
            isDismissible: true,
            flushbarPosition: position == SnackPosition.TOP
                ? FlushbarPosition.TOP
                : FlushbarPosition.BOTTOM,
            positionOffset:
                (i + 1) * 80.0, // Increased offset for better visibility
          ).show(Get.context!);
        }
      });
    }
  }

  static success(
      {required List<String> successList,
      int duration = 2,
      SnackPosition position = SnackPosition.TOP}) {
    if (successList.isEmpty) {
      successList = [S.current.success.tr];
    }
    for (var i = 0; i < successList.length; i++) {
      String message = successList[i].tr;
      message = removeQuotationAndSpecialCharacterFromString(message);
      Future.delayed(
        Duration(microseconds: 1000 * (i + 1)),
        () {
          Get.closeAllSnackbars();
          Get.rawSnackbar(
            progressIndicatorBackgroundColor: AppColors.transparentColor,
            progressIndicatorValueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.transparentColor),
            messageText: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.primary, size: 24)
                      .animate()
                      .rotate(
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut),
                  SizedBox(width: AppSizes.marginSmall),
                  Expanded(
                    child: Text(message.tr,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            color: AppColors.primaryTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: AppSizes.textMedium
                        ).copyWith(color: AppColors.primary),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            dismissDirection: DismissDirection.horizontal,
            snackPosition: position,
            backgroundColor: AppColors.white,
            borderRadius: 4,
            margin:  EdgeInsets.all(AppSizes.marginSmall),
            padding:  EdgeInsets.all(AppSizes.marginSmall),
            duration: Duration(seconds: duration + (i + 1)),
            isDismissible: true,
            forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
            showProgressIndicator: false,
            leftBarIndicatorColor: AppColors.primary,
            animationDuration: const Duration(seconds: 2),
            borderColor: AppColors.transparentColor,
            reverseAnimationCurve: Curves.easeOut,
            borderWidth: 0,
            instantInit: false,
            onTap: (snack) {},
          );
        },
      );
    }
  }
}
