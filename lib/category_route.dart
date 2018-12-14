import 'package:flutter/material.dart';
import './backdrop.dart';
import './category.dart';
import './category_row.dart';
import './unit.dart';
import './unit_converter.dart';

class CategoryRoute extends StatefulWidget {
  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  Category _category;

  @override
  void initState() {
    super.initState();

    _category = _categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      category: _category,
      frontPanel: UnitConverter(category: _category),
      backPanel: Padding(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 48,
        ),
        child: _buildCategoryWidgets(true),
      ),
      frontTitle: Text('Unit Converter'),
      backTitle: Text('Select a Category'),
    );

    // return Scaffold(
    //   backgroundColor: Colors.green[100],
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     centerTitle: true,
    //     title: Text(
    //       'Unit Converter',
    //       style: const TextStyle(fontSize: 30.0, color: Colors.black),
    //     ),
    //   ),
    //   body: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 8),
    //     child: _buildCategoryWidgets(true),
    //   ),
    // );
  }

  Widget _buildCategoryWidgets(bool isPortrait) => isPortrait
      ? ListView.builder(
          itemBuilder: (BuildContext context, int index) => _categories
              .map((category) => CategoryRow(
                    category: category,
                    icon: Icons.cake,
                    onTap: _onTapCategory,
                  ))
              .toList()[index],
          itemCount: _categories.length,
        )
      : GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3.0,
          children: _categories
              .map((category) => CategoryRow(
                    category: category,
                    icon: Icons.cake,
                    onTap: _onTapCategory,
                  ))
              .toList(),
        );

  void _onTapCategory(Category category) {
    setState(() {
      _category = category;
    });
  }
}

const _categories = [
  Category(
    name: 'Length',
    color: Colors.teal,
    units: [
      Unit(
        name: 'ABC',
        conversion: 1.0,
      ),
      Unit(
        name: 'DEF',
        conversion: 1.0,
      ),
      Unit(
        name: 'GHI',
        conversion: 1.0,
      ),
    ],
  ),
  Category(
    name: 'Area',
    color: Colors.orange,
    units: [
      Unit(
        name: 'ABC',
        conversion: 1.0,
      ),
      Unit(
        name: 'DEF',
        conversion: 1.0,
      ),
      Unit(
        name: 'GHI',
        conversion: 1.0,
      ),
    ],
  ),
  Category(
    name: 'Volume',
    color: Colors.pinkAccent,
    units: [
      Unit(
        name: 'ABC',
        conversion: 1.0,
      ),
      Unit(
        name: 'DEF',
        conversion: 1.0,
      ),
      Unit(
        name: 'GHI',
        conversion: 1.0,
      ),
    ],
  ),
  Category(
    name: 'Mass',
    color: Colors.blueAccent,
    units: [
      Unit(
        name: 'ABC',
        conversion: 1.0,
      ),
      Unit(
        name: 'DEF',
        conversion: 1.0,
      ),
      Unit(
        name: 'GHI',
        conversion: 1.0,
      ),
    ],
  ),
  Category(
    name: 'Time',
    color: Colors.yellow,
    units: [
      Unit(
        name: 'ABC',
        conversion: 1.0,
      ),
      Unit(
        name: 'DEF',
        conversion: 1.0,
      ),
      Unit(
        name: 'GHI',
        conversion: 1.0,
      ),
    ],
  ),
  Category(
    name: 'Digital Storage',
    color: Colors.greenAccent,
    units: [
      Unit(
        name: 'ABC',
        conversion: 1.0,
      ),
      Unit(
        name: 'DEF',
        conversion: 1.0,
      ),
      Unit(
        name: 'GHI',
        conversion: 1.0,
      ),
    ],
  ),
  Category(
    name: 'Energy',
    color: Colors.purpleAccent,
    units: [
      Unit(
        name: 'ABC',
        conversion: 1.0,
      ),
      Unit(
        name: 'DEF',
        conversion: 1.0,
      ),
      Unit(
        name: 'GHI',
        conversion: 1.0,
      ),
    ],
  ),
  Category(
    name: 'Currency',
    color: Colors.red,
    units: [
      Unit(
        name: 'ABC',
        conversion: 1.0,
      ),
      Unit(
        name: 'DEF',
        conversion: 1.0,
      ),
      Unit(
        name: 'GHI',
        conversion: 1.0,
      ),
    ],
  ),
];

List<Unit> _retrieveUnitList(String categoryName) => List.generate(
      10,
      (index) => Unit(
            name: '$categoryName Unit ${index + 1}',
            conversion: (index + 1).toDouble(),
          ),
    );
