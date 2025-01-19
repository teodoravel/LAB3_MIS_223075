import 'package:flutter/material.dart';
import 'package:joke_app/models/joke.dart';
import 'package:joke_app/services/api_services.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  State<RandomJokeScreen> createState() => RandomJokeScreenState();
}

class RandomJokeScreenState extends State<RandomJokeScreen> {
  late Future<Joke> _randomJokeFuture;

  @override
  void initState() {
    super.initState();
    _randomJokeFuture = ApiServices.fetchRandomJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke'),
      ),
      body: FutureBuilder<Joke>(
        future: _randomJokeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final joke = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.green.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.orange.shade200, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        joke.setup,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        joke.punchline,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No joke found.'));
          }
        },
      ),
    );
  }
}
