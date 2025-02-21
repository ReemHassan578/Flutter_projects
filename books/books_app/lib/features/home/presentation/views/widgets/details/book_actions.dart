import 'package:books_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/theming/my_colors.dart';

class BookActions extends StatelessWidget {
  const BookActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            backGroundColor: Colors.white,
            onPressed: () {},
            isBorderRadiusLeft: true,
            text: Text(
              'price',
              style: TextStyles.font16whiteMedium.copyWith(color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child:  CustomButton(
            backGroundColor:MyColors.pink,
            onPressed: () {},
            isBorderRadiusLeft: false,
            text: Text(
                'Free preview',
                style: TextStyles.font16whiteMedium,
              )
          ),
        ),
      ],
    );
  }
}
