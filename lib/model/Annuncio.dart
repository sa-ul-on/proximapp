class Annuncio {
  static const URGENT = 0;
  static const ALERT = 1;
  static const INFO = 2;

  final String text;
  final DateTime datetime;
  final String author;
  final int priority;

  Annuncio(this.text, this.datetime, this.author,
      [this.priority = Annuncio.INFO]);
}
