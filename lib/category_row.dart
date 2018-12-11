import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import './converter_route.dart';
import './unit.dart';

const _height = 100.0;

class CategoryRow extends StatelessWidget {
  final IconData icon;
  final ColorSwatch color;
  final String name;
  final List<Unit> units;

  CategoryRow({
    Key key,
    @required this.name,
    @required this.icon,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(icon != null),
        assert(color != null),
        assert(units != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Container(
          height: _height,
          child: InkWell(
            borderRadius: BorderRadius.circular(_height / 2),
            highlightColor: color,
            splashColor: color,
            onTap: () => _navigateToConverter(context),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      icon,
                      size: 60.0,
                    ),
                  ),
                  Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _navigateToConverter(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<Null>(
        builder: (BuildContext context) => ConverterRoute(
              color: color,
              name: name,
              units: units,
            ),
      ),
    );
  }
}
