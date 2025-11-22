import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live_test/details.dart';
import '../models/recipe.dart';

class FoodReceipes extends StatefulWidget {
  const FoodReceipes({super.key});

  @override
  State<FoodReceipes> createState() => _FoodReceipesState();
}

class _FoodReceipesState extends State<FoodReceipes> {
  late Future<List<Recipe>> recipesFuture;

  @override
  void initState() {
    super.initState();
    recipesFuture = loadRecipes();
  }

  Future<List<Recipe>> loadRecipes() async {
    final String jsonString =
    await rootBundle.loadString('assets/recipes.json');

    final List<dynamic> data = jsonDecode(jsonString);

    return data.map((e) => Recipe.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Recipes', style: TextStyle(color: Colors.white, fontSize: 22),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: recipesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final recipes = snapshot.data!;

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];

              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text(recipe.id.toString())),
                  title: Text(recipe.title, style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text("${recipe.calories} calories"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Details(recipe: recipe),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
