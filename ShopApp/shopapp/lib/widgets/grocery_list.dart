import 'package:flutter/material.dart';
import 'package:shopapp/models/grocery_item.dart';


class GroceryList extends StatefulWidget {
  final List<GroceryItem> list;
  final void Function(GroceryItem) rebuildP;
  const GroceryList({super.key,required this.list,required this.rebuildP});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (cntxt, index) {
        return Dismissible(key: ValueKey(widget.list[index].id), onDismissed: (direction) {
widget.rebuildP(widget.list[index]);

        },
          child: ListTile(
            //tileColor: list[index].category.color,
            title: Text(
              widget.list[index].name,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
            leading: Container(
                height: 24, width: 24, color: widget.list[index].category.color),
            trailing: Text(
              '${widget.list[index].quantity}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
