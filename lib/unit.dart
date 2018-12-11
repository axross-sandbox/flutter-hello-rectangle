import 'package:meta/meta.dart' show required;

class Unit {
  final String name;
  final double conversion;

  const Unit({
    @required this.name,
    @required this.conversion,
  })  : assert(name != null),
        assert(conversion != null);
}
