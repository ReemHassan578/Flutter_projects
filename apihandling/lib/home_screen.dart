import 'package:apiapp/cubit/users_cubit.dart';
import 'package:apiapp/user_model.dart';
import 'package:apiapp/users_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersCubit(repo: getIt<UsersRepo>())
        ..addUser(UserModel(
            name: 'name', email: 'email', gender: 'gender', status: 'status')),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<UsersCubit, UsersState>(
              listener: (context, state) {
                if (state is ErrorState) {
                  print(state.error);
                }
              },
              builder: (context, state) {
                final cubit = UsersCubit.get(context);

                /*   if (state is DeleteUserSucessState) {
                  return Container(
                    color: Colors.amber,
                    height: 50,
                    child: Text('user deleted successfully'),
                  );
                }
                return Center(child: CircularProgressIndicator()); */

                /*  if (cubit.newUser == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  color: Colors.amber,
                  height: 50,
                  child: Text('${cubit.newUser!.name}'),
                ); */
                /*  if (cubit.certainUser == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container(
                  color: Colors.amber,
                  height: 50,
                  child: Text('${cubit.certainUser!.name}'),
                ); */
                if (cubit.users == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: cubit.users!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.amber,
                        height: 50,
                        child: Text('${cubit.users![index]}'),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
