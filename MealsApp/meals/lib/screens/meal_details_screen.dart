import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import '../providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  // late AnimationController anCon;
  final Meal item;
  const MealDetailsScreen(this.item, {super.key});

  @override
  Widget build(BuildContext context, ref) {
    final List<Meal> curFav = ref.watch(favoriteMealsProvider);
    final bool isFavorite = curFav.contains(item);
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        actions: [
          IconButton(
            onPressed: () {
              bool add =
                  ref.read(favoriteMealsProvider.notifier).toggleFav(item);
              ScaffoldMessenger.of(context).clearSnackBars();
              SnackBar infobar = SnackBar(
                content: Text(add
                    ? '${item.name}  is added to  favorites'
                    : '${item.name} is removed from favorites'),
              );
              ScaffoldMessenger.of(context).showSnackBar(infobar);
            },
            icon: AnimatedSwitcher( 
              duration: const Duration(seconds: 1),
              transitionBuilder: (child, animation) {
                return RotationTransition(turns: Tween<double>(begin:0.8,end: 1).animate(animation),child: child);
              },
              child: Icon(isFavorite ? Icons.star : Icons.star_border,key: ValueKey(isFavorite)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: item.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text('Ingredients',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    )),
            const SizedBox(
              height: 14,
            ),
            for (final i in item.ingredients)
              Text(
                i,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            const SizedBox(
              height: 24,
            ),
            Text('Steps',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    )),
            const SizedBox(
              height: 14,
            ),
            for (final i in item.steps)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  i,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
