import 'package:flutter/material.dart';
import 'package:test1377/core/errors/errors.dart';

class ErrorPage extends StatelessWidget {
  final KError kError;
  final Function()? onRefresh;
  const ErrorPage({
    super.key,
    required this.kError,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off,
            size: 90,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Text(kError.message),
          ),
          ElevatedButton(
            onPressed: onRefresh,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
