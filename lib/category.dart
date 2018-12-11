import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Category extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String name;

  Category({
    Key key,
    @required this.name,
    @required this.icon,
    @required this.color,
  })  : assert(name != null),
        assert(icon != null),
        assert(color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Container(
          height: 100.0,
          child: InkWell(
            borderRadius: BorderRadius.circular(50.0),
            highlightColor: color,
            splashColor: color,
            onTap: () => print('I was tapped!'),
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
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
