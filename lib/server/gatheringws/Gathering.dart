class Gathering {
  final int id;
  final int placeId;
  final List<int> trackings;
  final DateTime startDate, endDate;

  Gathering(
      this.id, this.placeId, this.trackings, this.startDate, this.endDate);
}
