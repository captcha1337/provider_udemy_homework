import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GetColorProvider>.value(
            value: GetColorProvider()),
      ],
      child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(title: Consumer<GetColorProvider>(
                builder: (context, value, child) {
                  return Text(
                    'Provider Homework',
                    style: TextStyle(color: value.getColor()),
                  );
                },
              )),
              body: const MyAnimatedContainer())),
    );
  }
}

class MyAnimatedContainer extends StatelessWidget {
  const MyAnimatedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<GetColorProvider>(
          builder: (context, value, child) {
            return AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: 200,
              height: 200,
              color: value.getColor(),
            );
          },
        ),
        const SizedBox(
          height: 30,
        ),
        Consumer<GetColorProvider>(
          builder: (context, provider, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: provider.getColor()),
              child: const Icon(Icons.change_circle),
              onPressed: () => provider.changeColor(),
            );
          },
        )
      ],
    ));
  }
}

class GetColorProvider extends ChangeNotifier {
  Color color = Colors.blue;
  Color getColor() => color;

  void changeColor() {
    final random = Random();
    color = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    notifyListeners();
  }
}
