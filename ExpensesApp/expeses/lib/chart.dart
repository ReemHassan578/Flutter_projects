
import 'package:flutter/material.dart';

import 'chart_bar.dart';
import 'models/clothes.dart';
import 'models/food.dart';
import 'models/travel.dart';

class Chart extends StatelessWidget {
  double maxTotalExpenses=0;
   Chart({super.key}){ maxTotalExpenses =
        (Travel.total < Food.total && Food.total > Clothes.total)
            ? Food.total
            : ((Travel.total > Clothes.total) ? Travel.total : Clothes.total);}

  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(16),
      child:   Column(
        children: [
          Expanded(
            child: Row( crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: ChartBar(Clothes.total==0? 0 : Clothes.total/maxTotalExpenses)),
                const SizedBox(width:20),
                Expanded(child: ChartBar(Food.total==0? 0 : Food.total/maxTotalExpenses)),
                 const SizedBox(width:20),
                Expanded(child: ChartBar(Travel.total==0? 0 : Travel.total/maxTotalExpenses)),
              ],
            ),
          ),const SizedBox(height:10),
        const Expanded(
          child: Row(
            children: [
              Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Clothes.ic),
                    Text(Clothes.cat),
                  ],
                ),
              ),
              Expanded(
                child: Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Food.ic),
                    Text(Food.cat),
                  ],
                ),
              ),
              Expanded(
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Travel.ic),
                    Text(Travel.cat),
                  ],
                ),
              ),
            ],
          ),
        )
        ],
      ),
    );
  }
}
