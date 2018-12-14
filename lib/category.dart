import 'package:flutter/painting.dart' show Color;
import 'package:meta/meta.dart' show required;
import './unit.dart';

class Category {
  final String name;
  final Color color;
  final List<Unit> units;

  const Category({
    @required this.name,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(units != null);
}
