// This model could be used if we wanted more structure around joke types.
// For now, we just have a list of strings as types, so this is optional.
// The API just returns an array of strings for joke types
class JokeType {
  final String type;

  JokeType({required this.type});
}
