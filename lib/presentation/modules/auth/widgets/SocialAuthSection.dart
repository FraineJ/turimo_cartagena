import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_cartagena/core/di/article_injection.dart';
import 'package:turismo_cartagena/core/theme/sizes.dart';
import 'package:turismo_cartagena/presentation/bloc/auth/auth_bloc.dart';
import 'package:turismo_cartagena/presentation/modules/widgets/my_local_image_widget.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/theme/colors.dart';




class SocialAuthSection extends StatelessWidget {
  final String googleAuthTitle;
  const SocialAuthSection({super.key, this.googleAuthTitle = "Google"});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl()),
      child: BlocBuilder<AuthBloc, AuthBlocState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              if (state is! SocialAuthLoading) {
                context.read<AuthBloc>().add(SignInWithGoogleEvent());
              }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
                border: Border.all(color: AppColors.primary, width: .5),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.marginMedium, vertical: AppSizes.marginMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  state is SocialAuthLoading
                      ? const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(),
                  )
                      : const MyLocalImageWidget(
                    imagePath: "assets/images/social/google.png",
                    height: 25,
                    width: 25,
                    boxFit: BoxFit.contain,
                  ),
                  SizedBox(width: AppSizes.marginMedium),
                  Text(
                    googleAuthTitle,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizes.textMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
