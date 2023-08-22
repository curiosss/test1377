import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1377/features/tetris/presentation/controller/score_controller.dart';
import 'package:test1377/features/tetris/presentation/widgets/tetris_widget.dart';

//61960135
class TetrisPage extends StatefulWidget {
  const TetrisPage({super.key});

  @override
  State<TetrisPage> createState() => _TetrisPageState();
}

class _TetrisPageState extends State<TetrisPage> {
  GlobalKey<TetrisWidgetState> key = GlobalKey();
  ScoreController scoreController = ScoreController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    // top: 5,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: Colors.grey,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 0.5,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return TetrisWidget(
                            key: key,
                            boxConstraints: constraints,
                            scoreController: scoreController,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  return Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text('HIGH \nSCORE'),
                      Text(scoreController.highScore.value.toString()),
                      const SizedBox(height: 10),
                      const Text('TOTAL \nSCORE'),
                      Text(scoreController.totalScore.value.toString()),
                      const Spacer(),
                      scoreController.isPlaying.value
                          ? ElevatedButton(
                              onPressed: () {
                                key.currentState?.pause();
                                scoreController.isPlaying.value = false;
                              },
                              child: const Icon(Icons.pause),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                key.currentState?.resume();
                                scoreController.isPlaying.value = true;
                              },
                              child: const Icon(Icons.play_arrow),
                            )
                    ],
                  );
                },
              ),
            ),
          ],
        )),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    key.currentState?.left();
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(13),
                height: 80,
                width: 80,
                child: ElevatedButton(
                  onPressed: () {
                    key.currentState?.rotate();
                  },
                  child: const Icon(
                    Icons.refresh,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    key.currentState?.right();
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
