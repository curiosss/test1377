import 'package:flutter/widgets.dart';

class StubPage extends StatelessWidget {
  const StubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Container();
    });
  }
}
