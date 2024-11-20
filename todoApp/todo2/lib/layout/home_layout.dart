import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo/shared/components/components.dart';

import 'package:todo/shared/cubit/cubit.dart';

import '../models/task.dart';
import '../shared/cubit/states.dart';

class Home extends StatelessWidget {
  Home({super.key});

  //String? date = DateFormat().format(DateTime.now());
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final GlobalKey<ScaffoldState> scaff = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (cntx) => AppCubit()..openDB(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is InsertToDBState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaff,
            appBar: AppBar(
              title: Text(
                cubit.pages[cubit.page].title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                cubit.changeBottomNavBar(value);
              },
              currentIndex: cubit.page,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived'),
              ],
            ),
            body: ConditionalBuilder(
              builder: (context) => cubit.pages[cubit.page].page,
              condition: state is! InitialAppState,
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              child: Icon(cubit.bottomOpen ? Icons.add : Icons.edit),
              onPressed: () async {
                if (cubit.bottomOpen) {
                  if (formKey.currentState!.validate()) {
                    await cubit.insert(Task(
                        title: titleController.text,
                        date: dateController.text,
                        time: timeController.text));
                  }
                } else {
                  cubit.pressFAB(true);
                  titleController.clear();
                  dateController.clear();
                  timeController.clear();
                  scaff.currentState!
                      .showBottomSheet(
                        elevation: 100,
                        enableDrag: false,
                        (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    buildTextFormField(
                                        controller: titleController,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Title must not be empty';
                                          } else {
                                            return null;
                                          }
                                        },
                                        typeKeyboard: TextInputType.text,
                                        label: 'Title',
                                        prefix: Icons.title),
                                    const SizedBox(height: 10),
                                    buildTextFormField(
                                      controller: dateController,
                                      typeKeyboard: TextInputType.datetime,
                                      label: 'Date',
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Date must not be empty';
                                        }
                                        return null;
                                      },
                                      prefix: Icons.date_range_outlined,
                                      touch: () {
                                        showDatePicker(
                                                initialDate: DateTime.now(),
                                                context: context,
                                                firstDate: DateTime(2024),
                                                lastDate: DateTime(2030))
                                            .then(
                                          (value) {
                                            if (value == null) return;

                                            //  date = DateFormat().format(value);
                                            dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    buildTextFormField(
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Time must not be empty';
                                        }
                                        return null;
                                      },
                                      controller: timeController,
                                      typeKeyboard: TextInputType.datetime,
                                      label: 'Time',
                                      prefix: Icons.watch_later_outlined,
                                      touch: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then(
                                          (value) {
                                            if (value == null) return;
                                            timeController.text =
                                                value.format(context);
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      .closed
                      .then(
                        (value) {
                          cubit.pressFAB(false);
                        },
                      );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
