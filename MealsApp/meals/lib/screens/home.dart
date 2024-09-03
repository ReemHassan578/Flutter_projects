import 'package:flutter/material.dart';

import '../data/dummy_data.dart';

import '../widgets/category_grid_item.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController anCon;
  late Animation<Offset> an;

  @override
  void initState() {
    super.initState();
    anCon =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
//an=Tween<Offset>(begin: Offset(0,0.5),end: Offset(0,0)).animate(CurvedAnimation(parent: anCon, curve: Curves.linear));

    anCon.forward();
  }

  @override
  void dispose() {
    super.dispose();
    anCon.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //SlideTransition( position: an,
          AnimatedBuilder(
        animation: anCon,
        builder: (_, child) {
          return Padding(
              padding: EdgeInsets.only(top: 140 - anCon.value * 140),
              child: child);
        },
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            children: [
              for (final i in availableCategories) CategoryGridItem(i)
            ]),
      ),
    );
  }
}
