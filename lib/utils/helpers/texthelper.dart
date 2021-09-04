String codeToText(String code) {
  String coverted = code.replaceAll('-', ' ');
  return capitalizeFirstLetter(coverted);
}

String capitalizeFirstLetter(String str) {
  return str = str.replaceRange(0, 1, str.substring(0, 1).toUpperCase());
}

String formatCallingCode(String code) {
  return '+' + code;
}
