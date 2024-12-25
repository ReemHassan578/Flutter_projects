import 'package:flutter/material.dart';

import '../../core/constants/strings.dart';
import '../../data/models/movie.dart';

class MovieItem extends StatelessWidget {
  final BuildContext context;
  final Movie movie;
  const MovieItem({super.key, required this.context, required this.movie});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(moviesDetailsScreen, arguments: movie),
      child: Hero(
        tag: movie.id,
        child: GridTile(
          /*  footer: Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: MyColors.myGrey),
            child: Text(
              movie.title,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ), */
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Stack(
                children: [
                  FadeInImage.assetNetwork(
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/loading.gif',
                    image: movie.poster,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.black54),
                      child: Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
