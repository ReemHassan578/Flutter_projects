import 'dart:developer';

import 'package:flutter/material.dart';

import 'models/clothes.dart';
import 'models/food.dart';
import 'models/travel.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  void drawChart() {
    double maxTotalExpenses =
        (Travel.total < Food.total && Food.total > Clothes.total)
            ? Food.total
            : ((Travel.total > Clothes.total) ? Travel.total : Clothes.total);

    log('${Travel.total}');
    log('${Food.total}');
    log('${Clothes.total}');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(16),
      child: const Column(
        children: [
          Expanded(
            child: Row(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
