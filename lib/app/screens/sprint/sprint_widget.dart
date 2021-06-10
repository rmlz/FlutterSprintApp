import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/sprint/components/sprint_edit_widget.dart';
import 'package:social/app/screens/sprint/components/sprint_form_widget.dart';
import 'package:social/app/screens/sprint/components/sprint_list_widget.dart';

class SprintWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SprintWidgetState();
  }
}

class SprintWidgetState extends State {
  int _currentIndex = 0;
  final _screens = [
    SprintListWidget(),
    SprintFormWidget(),
    SprintEditWidget()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
        (
        title: Text('SPRINT MANAGER'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar:
      BottomNavigationBar
      (
        currentIndex: _currentIndex,
        items:
        [
          BottomNavigationBarItem
            (
            icon: Icon(Icons.list),
            label: 'Sprints',
          ),
          BottomNavigationBarItem
            (
            icon: Icon(Icons.file_copy),
            label: 'Nova Sprint',
          ),
          BottomNavigationBarItem
            (
            icon: Icon(Icons.change_circle),
            label: 'Editar Sprint',
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      )
    );
  }
}
