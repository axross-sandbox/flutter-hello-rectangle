import 'package:flutter/material.dart';
import './category.dart';
import './category_row.dart';
import './unit.dart';

class CategoryRoute extends StatefulWidget {
  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {
  final List<CategoryRow> _categoryRows = _categories
      .map((category) => CategoryRow(
            name: category.name,
            color: category.color,
            icon: Icons.cake,
            units: _retrieveUnitList(category.name),
          ))
      .toList();

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Unit Converter',
          style: const TextStyle(fontSize: 30.0, color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: _buildCategoryWidgets(true),
      ),
    );
  }

  Widget _buildCategoryWidgets(bool isPortrait) => isPortrait
      ? ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              _categoryRows[index],
          itemCount: _categoryRows.length,
        )
      : GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3.0,
          children: _categoryRows,
        );
}

const _categories = [
  Category(
    name: 'Length',
    color: Colors.teal,
  ),
  Category(
    name: 'Area',
    color: Colors.orange,
  ),
  Category(
    name: 'Volume',
    color: Colors.pinkAccent,
  ),
  Category(
    name: 'Mass',
    color: Colors.blueAccent,
  ),
  Category(
    name: 'Time',
    color: Colors.yellow,
  ),
  Category(
    name: 'Digital Storage',
    color: Colors.greenAccent,
  ),
  Category(
    name: 'Energy',
    color: Colors.purpleAccent,
  ),
  Category(
    name: 'Currency',
    color: Colors.red,
  ),
];

List<Unit> _retrieveUnitList(String categoryName) => List.generate(
      10,
      (index) => Unit(
            name: '$categoryName Unit ${index + 1}',
            conversion: (index + 1).toDouble(),
          ),
    );
