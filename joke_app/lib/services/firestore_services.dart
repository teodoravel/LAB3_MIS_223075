import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:joke_app/models/joke.dart';

class FirestoreServices {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addFavorite(Joke joke) async {
    await _db.collection('favorites').doc(joke.id.toString()).set({
      'id': joke.id,
      'type': joke.type,
      'setup': joke.setup,
      'punchline': joke.punchline,
    });
  }

  static Future<void> removeFavorite(Joke joke) async {
    await _db.collection('favorites').doc(joke.id.toString()).delete();
  }

  static Stream<List<Joke>> getFavoritesStream() {
    return _db.collection('favorites').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Joke(
          id: data['id'],
          type: data['type'],
          setup: data['setup'],
          punchline: data['punchline'],
        );
      }).toList();
    });
  }
}
