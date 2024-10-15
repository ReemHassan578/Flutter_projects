import 'dart:math';

final Random r = Random();

/*extension ContainAll on List {
  bool containsAll(int x, y, z) {
    return contains(x) && contains(y) && contains(z);
  }
}*/

class Game {
  /* test() {
    List tst = [2, 5, 7];
    dev.log(tst.containsAll(2, 5, 7).toString());
  }
*/
  List<String> board = List.generate(
    9,
    (index) {
      return '';
    },
  );
  bool twoPlayer;
  String player;
  Player playerX;
  Player playerO;
  String winner;
  Game({
    required this.twoPlayer,
  })  : player = 'X',
        playerX = Player.X(),
        playerO = Player.O(),
        winner = '';

  restart() {
    //test();
    board = List.generate(
      9,
      (index) {
        return '';
      },
    );
    player = 'X';
    winner = '';
  }

  void playAuto() {
    var indxBoard = board.asMap().entries.where(
      (element) {
        return element.value == '';
      },
    );
    List<int> empty = indxBoard.map(
      (e) {
        return e.key;
      },
    ).toList();
    if (empty.length == 1 || empty.isEmpty) return;
    int randindx = r.nextInt(empty.length);
    int indx = empty[randindx];
    winner = play2players(indx);
  }

  String play(int indx) {
    if (twoPlayer) {
      winner = play2players(indx);
    } else {
      winner = play2players(indx);
      if (winner == 'O' || winner == 'X') {
        return winner;
      }
      playAuto();
    }
    return winner;
  }

  String play2players(int indx) {
    if (player == 'X') {
      board[indx] = 'X';
      playerX.play();
      player = 'O';
      return checkWinner();
    } else {
      playerO.play();
      board[indx] = 'O';
      player = 'X';
      return checkWinner();
    }
  }

  String checkWinner() {
    // var list = board.indexed;
    for (int i = 0; i < 9; i += 3) {
      if (board[i] == board[i + 1] &&
          board[i + 1] == board[i + 2] &&
          board[i] != '') {
        winner = board[i];
        return winner;
      }
      // else if(board[i] == board[i+3] && board[i+6] == board[2]){
    }

    for (int i = 0; i < 3; i++) {
      if (board[i] == board[i + 3] &&
          board[i + 6] == board[i + 3] &&
          board[i] != '') {
        winner = board[i];
        return winner;
      }
    }
    //if(board[0] == board[1] && board[1] == board[2])
    if (board[0] == board[4] && board[8] == board[4] && board[0] != '') {
      winner = board[0];
      return winner;
    }
    if (board[2] == board[4] && board[4] == board[6] && board[2] != '') {
      winner = board[2];
      return winner;
    }
    return winner;
  }
}

class Player {
  String type;
  Player.X() : type = 'X';
  Player.O() : type = 'O';
  play() {
    if (type == 'X') {
      //draw x
    } else {
      //draw o
    }
  }
}
