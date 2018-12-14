import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import './category.dart';

const _height = 100.0;

class CategoryRow extends StatelessWidget {
  final Category category;
  final IconData icon;
  final ValueChanged<Category> onTap;

  CategoryRow({
    Key key,
    @required this.category,
    @required this.icon,
    @required this.onTap,
  })  : assert(category != null),
        assert(icon != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Container(
          height: _height,
          child: InkWell(
            borderRadius: BorderRadius.circular(_height / 2),
            highlightColor: category.color,
            splashColor: category.color,
            onTap: () => onTap(category),
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
                      category.name,
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

  // void _navigateToConverter(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute<Null>(
  //       builder: (BuildContext context) => ConverterRoute(
  //             color: color,
  //             name: name,
  //             units: units,
  //           ),
  //     ),
  //   );
  // }
}
