import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:social/app/screens/sprint/sprint_api.dart';
import 'package:social/app/screens/sprint/sprint_bloc.dart';
import 'package:social/app/screens/sprint/sprint_widget.dart';

class SprintModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => SprintBloc(i.getDependency<SprintApi>())),
  ];

  @override
  Widget get view => SprintWidget();

  @override
  List<Dependency> get dependencies => [
    Dependency(_getFeedApi),
  ];

  SprintApi _getFeedApi(Inject i) {
    return SprintApi();
  }


  static Inject get to {
    return Inject<SprintModule>.of();
  }

}
