import 'package:flutter/material.dart';
import 'package:joke_app/services/api_services.dart';
import 'package:joke_app/screens/jokes_by_type_screen.dart';
import 'package:joke_app/screens/random_joke_screen.dart';
import 'package:joke_app/screens/favorites_screen.dart';

class TypesListScreen extends StatefulWidget {
  const TypesListScreen({Key? key}) : super(key: key);

  @override
  State<TypesListScreen> createState() => TypesListScreenState();
}

class TypesListScreenState extends State<TypesListScreen> {
  late Future<List<String>> _jokeTypesFuture;

  @override
  void initState() {
    super.initState();
    _jokeTypesFuture = ApiServices.fetchJokeTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joke Types'),
        actions: [
          // Favorites icon
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: _jokeTypesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final types = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: types.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final type = types[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JokesByTypeScreen(type: type),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.green.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side:
                            BorderSide(color: Colors.orange.shade600, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          type,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
