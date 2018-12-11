import 'package:flutter/material.dart';
import 'package:meta/meta.dart' show required;
import './unit.dart';

class ConverterRoute extends StatefulWidget {
  final String name;
  final Color color;
  final List<Unit> units;

  const ConverterRoute({
    @required this.name,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(units != null);

  @override
  _ConverterRouteState createState() => _ConverterRouteState();
}

class _ConverterRouteState extends State<ConverterRoute> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: Text(widget.name, style: Theme.of(context).textTheme.display1),
          centerTitle: true,
          backgroundColor: widget.color,
        ),
        body: ListView(
          children: widget.units
              .map(
                (unit) => Container(
                      color: widget.color,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            unit.name,
                            style: Theme.of(context).textTheme.headline,
                          ),
                          Text(
                            'Conversion: ${unit.conversion}',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ],
                      ),
                    ),
              )
              .toList(),
        ),
      );
}
