import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';
import '../widgets/filter_item.dart';

class FiltersScreen extends ConsumerWidget {
  final String title;
  //final Map<Filter,bool> filter;
  const FiltersScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context,ref) {
    final Map<Filter, bool> filter = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          FilterItem(
            filter[Filter.gluten]!,
            (bool value) {
              ref.read(filterProvider.notifier).setFilter(Filter.gluten, value);
            },
            subTitle: 'Only include gluten-free meals.',
            title: 'Gluten-free',
          ),
          FilterItem(
            filter[Filter.lactose]!,
            (bool value) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.lactose, value);
            },
            subTitle: 'Only include lactose-free meals.',
            title: 'Lactose-free',
          ),
          FilterItem(
            filter[Filter.vegan]!,
            (bool value) {
              ref.read(filterProvider.notifier).setFilter(Filter.vegan, value);
            },
            subTitle: 'Only include vegan meals.',
            title: 'Vegan',
          ),
          FilterItem(
            filter[Filter.vegetarian]!,
            (bool value) {
              ref
                  .read(filterProvider.notifier)
                  .setFilter(Filter.vegetarian, value);
            },
            subTitle: 'Only include vegetarian meals.',
            title: 'Vegetarian',
          ),
        ],
      ),
    );
  }
}
