//dataclass for sights user signed to visit or have already visited
class Intention {
  int placeId;
  DateTime? date;
  bool hasVisited;

  Intention({required this.placeId, this.date, this.hasVisited = false});

  Intention.empty(int id)
      : placeId = id,
        date = null,
        hasVisited = false;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        other is Intention && placeId == other.placeId;
  }

  @override
  int get hashCode => placeId;
}
