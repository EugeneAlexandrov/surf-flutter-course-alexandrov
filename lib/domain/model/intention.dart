import 'package:places/domain/model/sight.dart';

//dataclass for sights user signed to visit or have already visited
class Intention {
  Sight sight;
  DateTime date;
  bool hasVisited;

  Intention(this.sight, this.date, this.hasVisited);
}
