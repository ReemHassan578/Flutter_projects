import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

import '../widgets/category_grid_item.dart';


class Home extends StatelessWidget {
    
  

  const Home({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2,
          crossAxisSpacing:2 ,
          mainAxisSpacing: 2,
          
        ),
        children:[ for(final i in availableCategories) CategoryGridItem(i) ]
      ),
    );
  }
}
