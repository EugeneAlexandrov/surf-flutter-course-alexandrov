//dataclass for sights user signed to visit or have already visited
class Intention {
  int id;
  int sightId;
  DateTime? date;
  bool hasVisited;

  Intention(
      {required this.id,
      required this.sightId,
      this.date,
      this.hasVisited = false});

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        other is Intention && sightId == other.sightId;
  }

  @override
  int get hashCode => id;
}
