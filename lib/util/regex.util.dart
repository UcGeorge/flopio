class RegexUtil {
  static RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static RegExp nameRegex = RegExp(r"^[a-zA-Z]*$");
  static RegExp passwordRegex = RegExp(
      r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*[!#$%&'()*+,-./:;<=>?@^_`{|}~"
      r'"]).{8,}$');

  static RegExp simplePhoneRegex = RegExp(r"^[0-9]{11}$");

  static RegExp phoneRegex =
      RegExp(r"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$");

  static RegExp webUrlRegex = RegExp(
      r"^((https?|ftp|smtp):\/\/)?(www.)?[a-z0-9]+\.[a-z]+(\/[a-zA-Z0-9#]+\/?)*$");
}
