import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/widgets/NewContainer.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = NewsCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConditionalBuilder(
              condition: cubit.science.isNotEmpty,
              fallback: (context) {
                return const Center(child: CircularProgressIndicator());
              },
              builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) =>
                    NewContainer(data: cubit.science[index]),
                itemCount: cubit.science.length,
              ),
            ),
          );
        });
  }
}
