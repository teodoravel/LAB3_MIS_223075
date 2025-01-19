import 'package:flutter/material.dart';
import 'package:joke_app/models/joke.dart';
import 'package:joke_app/services/api_services.dart';
import 'package:joke_app/services/firestore_services.dart';

class JokesByTypeScreen extends StatefulWidget {
  final String type;

  const JokesByTypeScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<JokesByTypeScreen> createState() => JokesByTypeScreenState();
}

class JokesByTypeScreenState extends State<JokesByTypeScreen> {
  late Future<List<Joke>> _jokesFuture;

  @override
  void initState() {
    super.initState();
    _jokesFuture = ApiServices.fetchJokesByType(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes: ${widget.type}'),
      ),
      body: FutureBuilder<List<Joke>>(
        future: _jokesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final jokes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return Card(
                  color: Colors.green.shade100,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.orange.shade300, width: 2),
                  ),
                  child: ListTile(
                    title: Text(
                      joke.setup,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(joke.punchline),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {
                        FirestoreServices.addFavorite(joke);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Added to favorites!"),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
