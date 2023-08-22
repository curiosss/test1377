import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test1377/features/tetris/presentation/constants/colors.dart';
import 'package:test1377/features/tetris/presentation/constants/shapes.dart';
import 'package:test1377/features/tetris/presentation/controller/score_controller.dart';
import 'package:test1377/features/tetris/presentation/models/shape_model.dart';
import 'package:test1377/features/tetris/presentation/widgets/game_over_dialog.dart';

class TetrisWidget extends StatefulWidget {
  final BoxConstraints boxConstraints;
  final ScoreController scoreController;
  const TetrisWidget({
    super.key,
    required this.boxConstraints,
    required this.scoreController,
  });

  @override
  State<TetrisWidget> createState() => TetrisWidgetState();
}

class TetrisWidgetState extends State<TetrisWidget> {
  double size = 10;
  List<List<int>> array = [];
  int totalScore = 0;

  @override
  initState() {
    init();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    size = widget.boxConstraints.maxWidth / 10;
    start();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  ShapeModel currentShape = shapes.first;
  Timer? timer;

  init() {
    for (int i = 0; i < 20; i++) {
      array.add([]);
      for (int j = 0; j < 10; j++) {
        array[i].add(0);
      }
    }
  }

  updateScore() {
    totalScore += 10;
    widget.scoreController.updateScore(totalScore);
  }

  left() {
    pause();
    if (canMoveLeft()) {
      for (int i = 0; i < currentShape.height; i++) {
        for (int j = 0; j < currentShape.width; j++) {
          if (array[currentShape.posY - i][currentShape.posX + j] > 0) {
            array[currentShape.posY - i][currentShape.posX + j - 1] =
                array[currentShape.posY - i][currentShape.posX + j];
            array[currentShape.posY - i][currentShape.posX + j] = 0;
          }
        }
      }
      currentShape.posX = currentShape.posX - 1;
      setState(() {});
    }
    resume();
  }

  right() {
    pause();
    if (canMoveRight()) {
      for (int i = 0; i < currentShape.height; i++) {
        for (int j = 1; j <= currentShape.width; j++) {
          if (array[currentShape.posY - i]
                  [currentShape.posX + currentShape.width - j] >
              0) {
            array[currentShape.posY - i]
                    [currentShape.posX + currentShape.width - j + 1] =
                array[currentShape.posY - i]
                    [currentShape.posX + currentShape.width - j];
            array[currentShape.posY - i]
                [currentShape.posX + currentShape.width - j] = 0;
          }
        }
      }
      currentShape.posX = currentShape.posX + 1;
      setState(() {});
    }
    resume();
  }

  pause() {
    timer?.cancel();
  }

  resume() {
    timer?.cancel();
    timer = Timer.periodic(
      const Duration(milliseconds: 700),
      (timer) {
        moveShape();
      },
    );
  }

  Random random = Random();
  start() {
    ShapeModel shape = shapes[random.nextInt(shapes.length)];
    // ShapeModel shape = shapes[5];
    shape.applyColor(random.nextInt(tetrisColors.length) + 1);
    newShape(
      random.nextInt(10),
      shape,
    );
    resume();
  }

  newShape(int x, ShapeModel shape) {
    currentShape = shape;
    if (x + shape.width > 10) {
      x = 10 - shape.width;
    }
    shape.posX = x;
    shape.posY = shape.height - 1;
    for (int i = 0; i < shape.height; i++) {
      for (int j = 0; j < shape.width; j++) {
        array[shape.posY - i][x + j] =
            shape.coordnts[currentShape.height - 1 - i][j];
      }
    }
    setState(() {});
  }

  moveShape() {
    if (canMoveShape()) {
      for (int i = 0; i < currentShape.height; i++) {
        for (int j = 0; j < currentShape.width; j++) {
          if (currentShape.coordnts[currentShape.height - 1 - i][j] > 0) {
            array[currentShape.posY + 1 - i][currentShape.posX + j] =
                array[currentShape.posY - i][currentShape.posX + j];
            array[currentShape.posY - i][currentShape.posX + j] = 0;
          }
        }
      }
      currentShape.posY = currentShape.posY + 1;
      setState(() {});
    } else {
      clearField();
    }
  }

  clearField() async {
    timer?.cancel();

    if (currentShape.posY - currentShape.height < 0) {
      gameOver();
      return;
    }

    for (int i = array.length - 1; i > -1; i--) {
      // print('clearing col:$i');
      if (await deleteRow(i)) {
        break;
      }
    }
    //
    start();
  }

  gameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return GameOverDialog(
          onTap: newGame,
        );
      },
    );
  }

  newGame() {
    Navigator.pop(context);
    for (int i = 0; i < array.length; i++) {
      for (int j = 0; j < 10; j++) {
        array[i][j] = 0;
      }
    }
    totalScore = -10;
    updateScore();
    setState(() {});
    start();
  }

  int cnr = 0;
  Future<bool> deleteRow(int index) async {
    cnr = 0;
    for (int j = 0; j < 10; j++) {
      if (array[index][j] > 0) {
        cnr++;
      }
    }
    if (cnr > 9) {
      array.removeAt(index);

      array.insert(0, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      updateScore();
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 300));
      return deleteRow(index);
    } else if (cnr == 0) {
      return true;
    }
    return false;
  }

  bool canMoveShape() {
    //checking for bottom borders
    if (currentShape.posY + 1 > 19) {
      return false;
    }

    for (int j = 0; j < currentShape.width; j++) {
      int i = 0;
      while (true) {
        if (currentShape.coordnts[currentShape.height - 1 - i][j] > 0) {
          if (array[currentShape.posY - i + 1][currentShape.posX + j] > 0) {
            return false;
          }
          break;
        }
        i++;
        if (i > 3) {
          break;
        }
      }
    }
    return true;
  }

  bool canMoveLeft() {
    if (currentShape.posX == 0) {
      return false;
    }
    for (int i = 0; i < currentShape.height; i++) {
      if (array[currentShape.posY - i][currentShape.posX] == 0) {
        continue;
      } else if (array[currentShape.posY - i][currentShape.posX - 1] > 0) {
        return false;
      }
    }
    return true;
  }

  bool canMoveRight() {
    if (currentShape.posX + currentShape.width > 9) {
      return false;
    }
    for (int i = 0; i < currentShape.height; i++) {
      if (array[currentShape.posY - i]
              [currentShape.posX + currentShape.width - 1] ==
          0) {
        continue;
      } else if (array[currentShape.posY - i]
              [currentShape.posX + currentShape.width] >
          0) {
        return false;
      }
    }
    return true;
  }

  bool canRotate() {
    int dx, dy, movingX, movingY, centerX1;
    centerX1 = currentShape.posX + currentShape.width - 1;

    for (int i = 0; i < currentShape.height; i++) {
      for (int j = 0; j < currentShape.width; j++) {
        //check for shapes bottom right cell is it filled or emtpy
        if (array[currentShape.posY - i][currentShape.posX + j] > 0) {
          dx = currentShape.posX + j - centerX1;
          dy = i;
          movingY = currentShape.posY + dx;
          movingX = currentShape.posX + dy;
          if (movingY <= currentShape.posY &&
              movingY >= currentShape.posY - currentShape.height + 1 &&
              movingX >= currentShape.posX &&
              movingX <= currentShape.posX + currentShape.width - 1) {
            //inside shape
          } else {
            //outside shape
            if (array[movingY][movingX] > 0) {
              return false;
            }
          }
        } else {
          continue;
        }
      }
    }
    return true;
  }

  rotate() {
    pause();

    if (canRotate()) {
      for (int i = 0; i < currentShape.height; i++) {
        for (int j = 0; j < currentShape.width; j++) {
          if (currentShape.coordnts[currentShape.height - 1 - i][j] > 0) {
            array[currentShape.posY - i][currentShape.posX + j] = 0;
          }
        }
      }
      currentShape.rotate();
      // return;
      for (int i = 0; i < currentShape.height; i++) {
        for (int j = 0; j < currentShape.width; j++) {
          if (currentShape.coordnts[currentShape.height - 1 - i][j] > 0) {
            array[currentShape.posY - i][currentShape.posX + j] =
                currentShape.coordnts[currentShape.height - 1 - i][j];
          }
        }
      }
      setState(() {});
    }
    resume();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: array.map((col) {
        return Row(
          children: col.map((e) {
            return SizedBox(
              height: size,
              width: size,
              child: e > 0
                  ? Container(
                      margin: const EdgeInsets.all(1),
                      color: tetrisColors[e - 1],
                    )
                  : Container(),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
