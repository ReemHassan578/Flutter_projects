import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal item;
  const MealItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Stack(
          children: [
            FadeInImage(placeholder: MemoryImage(kTransparentImage), image: NetworkImage(item.imageUrl)),
            //Image.network(item.imageUrl),
           
            Positioned(
              bottom: 0,right: 0,left: 0,
              child: Container(
               
                color: Colors.black87,
                child: Column(
                  children: [
                    Text(maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                      item.name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white70) ,
                    ),
                  const  SizedBox(height:10),
                  const Row(children: [
                    
                  ],)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
