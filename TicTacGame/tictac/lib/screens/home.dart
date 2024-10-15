import 'package:flutter/material.dart';
import 'package:tictac/widgets/one_square.dart';

import '../models/game_logic.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool twoPlayers = false;
  late Game game;
  String turn = 'X';
  String winner = '';
  bool gameEnd = false;
  bool restart = false;
  int turns = 0;
  @override
  void initState() {
    super.initState();
    game = Game(twoPlayer: twoPlayers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...restBlock()[0],
                expandedGrid(),
                ...restBlock()[1],
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: Column(
                     
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...restBlock()[0],
                        ...restBlock()[1],
                      ]),
                ),
                expandedGrid()
              ],
            );
          }
        },
      )),
    );
  }

  restartGame() {
    game = Game(twoPlayer: twoPlayers);
    turn = 'X';
    winner = '';
    gameEnd = false;
    game.restart();
    restart = true;
    turns = 0;
  }

  List restBlock() {
    return [
      [
        SwitchListTile.adaptive(
          title: Center(
            child: Text('Turn ON/Off two players mode',
                style: Theme.of(context).textTheme.titleLarge!),
          ),
          value: twoPlayers,
          onChanged: (value) {
            setState(() {
              twoPlayers = value;
              restartGame();
            });
          },
        ),
        Text(
          'IT\'S TURN! $turn',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
      [
        Text(
          'WINNER IS $winner',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                restartGame();
              });
            },
            label: const Text('Repeat The Game'),
            icon: const Icon(Icons.replay_rounded),
          ),
        )
      ]
    ];
  }

  Widget expandedGrid() {
    return Expanded(
      child: GridView.count(
          crossAxisCount: 3,
          // shrinkWrap: true,
          children: [
            for (int i = 0; i < 9; i++)
              OneSquare(
                  restart: restart,
                  gameEnd: gameEnd,
                  turn: game.board[i],
                  play: () {
                    setState(() {
                      turns = twoPlayers ? turns + 1 : turns + 2;
                      winner = game.play(i);
                      restart = false;
                      turn = game.player;
                      if (winner == 'X' || winner == 'O') {
                        gameEnd = true;
                      }
                      if (turns >= 9 && winner == '') {
                        gameEnd = true;
                        winner = ' Draw';
                      }
                    });
                  })
          ]),
    );
  }
}
