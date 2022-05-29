class fct {
  static String getString(List<String> list) {
    String text = "";
    list.forEach((element) {
      text = text + " " + element;
    });
    return text;
  }
}
