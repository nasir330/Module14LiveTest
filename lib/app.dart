import 'package:flutter/material.dart';
import 'package:live_test/food_recipes.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Module 14| Live Test',
      debugShowCheckedModeBanner: false,
      home: FoodReceipes(),
    );
  }
}
