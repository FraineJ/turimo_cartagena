import 'package:flutter/material.dart';
import 'package:turismo_cartagena/core/theme/colors.dart';
import 'package:turismo_cartagena/core/widgets/all-widgets.dart' as WIDGETS;
import 'package:turismo_cartagena/domain/models/partner.model.dart';

import '../../../../core/theme/sizes.dart';

class ReviewDialog extends StatefulWidget {
  final PartnersModel partner;

  const ReviewDialog({super.key, required this.partner});
  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  int _rating = 0;
  TextEditingController _reviewController = TextEditingController();

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.partner.name,
              style: TextStyle(
                  fontSize: AppSizes.textMedium,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: AppSizes.marginSmall),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    _rating > index
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: AppSizes.heightMedium,
                  ),
                  onPressed: () => _setRating(index + 1),
                );
              }),
            ),
            SizedBox(height: AppSizes.marginSmall),
            TextField(
              controller: _reviewController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Comparte detalles de tu experiencia en este lugar',
                hintStyle:  TextStyle(
                  color: Colors.grey,
                  fontSize: AppSizes.textSmall,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            SizedBox(height: AppSizes.marginMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                WIDGETS.RegistrationButton(

                  text: 'Cancelar',
                  color: AppColors.error,
                  width: AppSizes.screenWidth / 3,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),

                WIDGETS.ButtonPrimaryCustom(
                  text: 'Publicar',
                  color: AppColors.primary,
                  width: AppSizes.screenWidth / 3,
                  onPressed: (){
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
