import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal item;
  final Function(Meal item) ontap;
  const MealItem(this.item, this.ontap, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap(item);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(8),
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                    tag: item.id,
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )),
                //Image.network(item.imageUrl),

                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    color: Colors.black87,
                    child: Column(
                      children: [
                        Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 5),
                      Text('${item.duration} min')
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.shopping_bag_rounded,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 5),
                      Text(item.complexity.name)
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money_rounded,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 5),
                      Text(item.affordability.name)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
