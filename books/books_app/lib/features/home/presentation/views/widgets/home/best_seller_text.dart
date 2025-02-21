import 'package:flutter/material.dart';

import '../../../../../../core/theming/text_styles.dart';


class BestSellerText extends StatelessWidget {
  const BestSellerText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
                'Best Seller',
                style: TextStyles.font24WhiteBold.copyWith(fontFamily: TextStyles.gTSectraFineRegularFont),
              );
  }
}