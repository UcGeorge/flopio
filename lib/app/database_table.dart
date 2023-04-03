abstract class DatabaseTable {
  String get createScript;
  String get tableName;

  static String users = "users";
  static String cards = "cards";
  static String sessions = "sessions";
  static String answers = "answers";
}
