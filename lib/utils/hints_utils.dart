class HintsUtils {
  static String getWordLength(String word) {
    return "I'm a ${word.length} letter word";
  }

  static String getFirstLetter(String word) {
    return "I start with '${word.substring(0, 1)}'";
  }

  static String getLastLetter(String word) {
    return "I end with '${word.substring(word.length - 1)}'";
  }
}
