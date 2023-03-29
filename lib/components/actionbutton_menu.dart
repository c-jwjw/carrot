import 'package:flutter/material.dart';

class ActionButtonMenu extends StatefulWidget {
  const ActionButtonMenu({super.key});

  @override
  State<ActionButtonMenu> createState() => _ActionButtonMenuState();
}

class _ActionButtonMenuState extends State<ActionButtonMenu> {
  String dropdownValue = '1st';
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButton<String>(
          value: dropdownValue,
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.grey,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['1st','2nd','3rd']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value : value,
              child : Text(value),
            ); 
          }).toList(),
        ),
      ),
    );
  }
}