import 'package:flutter/material.dart';
import 'package:joke_app/models/joke.dart';
import 'package:joke_app/services/firestore_services.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Jokes')),
      body: StreamBuilder<List<Joke>>(
        stream: FirestoreServices.getFavoritesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final favorites = snapshot.data!;
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final joke = favorites[index];
              return Card(
                margin: const EdgeInsets.all(8),
                color: Colors.green.shade50,
                child: ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      FirestoreServices.removeFavorite(joke);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Removed from favorites."),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
