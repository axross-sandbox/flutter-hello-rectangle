import 'package:flutter/painting.dart' show Color;
import 'package:meta/meta.dart' show required;

class Category {
  final String name;
  final Color color;

  const Category({
    @required this.name,
    @required this.color,
  })  : assert(name != null),
        assert(color != null);
}
