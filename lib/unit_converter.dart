import 'package:flutter/material.dart';
import 'package:meta/meta.dart' show required;
import './category.dart';
import './unit.dart';

class UnitConverter extends StatefulWidget {
  final Category category;

  const UnitConverter({
    @required this.category,
  }) : assert(category != null);

  @override
  _UnitConverterState createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ConverterGroup(
                labelText: 'From',
                units: widget.category.units,
              ),
              _CompareArrows(),
              _ConverterGroup(
                labelText: 'To',
                units: widget.category.units,
              ),
            ],
          ),
        ),
      );

  // Scaffold(
  //       appBar: AppBar(
  //         elevation: 1.0,
  //         title: Text(widget.name, style: Theme.of(context).textTheme.display1),
  //         centerTitle: true,
  //         backgroundColor: widget.color,
  //       ),
  //       body: Container(
  //         padding: EdgeInsets.all(16),
  //         child: Column(
  //           children: <Widget>[
  //             _ConverterGroup(
  //               labelText: 'From',
  //               units: widget.units,
  //             ),
  //             _CompareArrows(),
  //             _ConverterGroup(
  //               labelText: 'To',
  //               units: widget.units,
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
}

class _ConverterGroup extends StatefulWidget {
  final String labelText;
  final List<Unit> units;

  _ConverterGroup({
    @required this.labelText,
    @required this.units,
  })  : assert(labelText != null),
        assert(units != null),
        assert(units.length >= 1);

  @override
  _ConverterGroupState createState() => _ConverterGroupState();
}

class _ConverterGroupState extends State<_ConverterGroup> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isInputtedValueValid = true;
  Unit _selectedUnit;

  @override
  void initState() {
    super.initState();

    _selectedUnit = widget.units.first;

    _textEditingController.addListener(() {
      setState(() {
        final value = _textEditingController.text;

        if (value.isEmpty) {
          _isInputtedValueValid = true;

          return;
        }

        try {
          double.parse(value);
        } on FormatException catch (error) {
          _isInputtedValueValid = false;

          return;
        }

        _isInputtedValueValid = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 20),
              decoration: InputDecoration(
                labelText: widget.labelText,
                filled: true,
                fillColor: Colors.grey[200],
                errorText: _isInputtedValueValid ? null : 'Invalid',
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[600],
                  ),
                ),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 7.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectedUnit,
                    items: widget.units
                        .map(
                          (unit) => DropdownMenuItem(
                                child: Text(unit.name),
                                value: unit,
                              ),
                        )
                        .toList(),
                    onChanged: (Unit unit) {
                      print(unit.name);

                      setState(() {
                        _selectedUnit = unit;
                      });
                    },
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _CompareArrows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Center(
        child: Icon(
          Icons.compare_arrows,
          size: 40,
        ),
      ),
    );
  }
}
