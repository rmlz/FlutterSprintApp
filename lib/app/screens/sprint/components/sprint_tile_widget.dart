import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/sprint/sprint_bloc.dart';
import 'package:social/app/screens/sprint/sprint_module.dart';
import 'package:social/app/shared/models/sprint_model.dart';

class SprintTileWidget extends StatelessWidget {

  final SprintModel sprint;
  SprintTileWidget(this.sprint);

  @override
  Widget build(BuildContext context) {
    return Text(sprint.nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }
}
