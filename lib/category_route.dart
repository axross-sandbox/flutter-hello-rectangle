import 'package:flutter/material.dart';
import './category.dart';

const _categoryNames = [
  'Length',
  'Area',
  'Volume',
  'Mass',
  'Time',
  'Digital Storage',
  'Energy',
  'Currency',
];

class CategoryRoute extends StatelessWidget {
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
        child: _buildCategoryWidgets(true),
      ),
    );
  }
}

Widget _buildCategoryWidgets(bool portrait) {
  if (portrait) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => Category(
            name: _categoryNames[index],
            color: Colors.blueAccent,
            icon: Icons.cake,
          ),
      itemCount: _categoryNames.length,
    );
  } else {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 3.0,
      children: _categoryNames
          .map((categoryName) => Category(
                name: categoryName,
                color: Colors.blueAccent,
                icon: Icons.cake,
              ))
          .toList(),
    );
  }
}
