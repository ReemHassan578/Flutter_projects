import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/cubit/movies_cubit.dart';
import '../../core/constants/my_colors.dart';
import '../../data/models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailsScreen({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: MyColors.myWhite,
                )),
            backgroundColor: MyColors.myGrey,
            expandedHeight: 450,
            // stretch: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: const TextStyle(fontSize: 15, color: MyColors.myWhite),
              ),
              background: Hero(
                tag: movie.id,
                child: Image.network(
                  fit: BoxFit.cover,
                  movie.poster,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildOneLine('Director', movie.director),
                      buildDivider(398),
                      buildOneLine('Country', movie.country),
                      buildDivider(400),
                      buildOneLine('Production', movie.production),
                      buildDivider(375),
                      buildOneLine('Plot', movie.plot),
                      buildDivider(430),
                      buildOneLine('Actors', movie.actors.join(' / ')),
                      buildDivider(410),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<MoviesCubit, MoviesStates>(
                        builder: (context, state) {
                          if (state is ChangeOpacityState) {
                            Future.delayed(
                              const Duration(seconds: 4),
                              () {},
                            );
                          }
                          final cubit = MoviesCubit.get(context);
                          Future.delayed(
                            const Duration(seconds: 1),
                            () {
                              cubit.changeOpacity();
                            },
                          );
                          return Center(
                            child: AnimatedOpacity(
                              opacity: cubit.opacity,
                              duration: const Duration(seconds: 1),
                              child: Text(
                                movie.rating.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.myYellow,
                                    fontSize: 24),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildDivider(double endIntend) {
    return Divider(
      thickness: 2,
      color: MyColors.myYellow,
      endIndent: endIntend,
      height: 35,
    );
  }

  Widget buildOneLine(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title : ',
            style: const TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(color: MyColors.myWhite, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
