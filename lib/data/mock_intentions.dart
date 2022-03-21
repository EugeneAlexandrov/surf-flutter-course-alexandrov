import 'package:places/data/mock_sights.dart';
import 'package:places/domain/model/intention.dart';

final List<Intention> mockIntentionsList = [
  Intention(mockSights[0], DateTime(2021, 8, 5), false),
  Intention(mockSights[1], DateTime(2022, 1, 15), false),
  Intention(mockSights[2], DateTime(2021, 10, 15), true),
  Intention(mockSights[3], DateTime(2022, 01, 15), true),
];