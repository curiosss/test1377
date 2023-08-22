import 'package:flutter/material.dart';

class GameOverDialog extends StatelessWidget {
  final Function()? onTap;
  const GameOverDialog({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(
            13,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: onTap,
                child: const Text(
                  'Try again',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
