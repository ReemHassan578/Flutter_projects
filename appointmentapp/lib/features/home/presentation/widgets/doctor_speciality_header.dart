import 'package:flutter/material.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class DoctorSpecialityHeader extends StatelessWidget {
  const DoctorSpecialityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
            children: [
              Text(
                'Doctor Speciality',
                style: TextStyles.font18BlackBold
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Spacer(),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'see all',
                    style: TextStyles.font12lightGreyRegular
                        .copyWith(color: MyColors.bluePrimaryColor),
                  ))
            ],
          );
  }
}