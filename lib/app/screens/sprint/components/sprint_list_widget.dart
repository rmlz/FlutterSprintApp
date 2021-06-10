import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/sprint/components/sprint_tile_widget.dart';
import 'package:social/app/screens/sprint/sprint_bloc.dart';
import 'package:social/app/screens/sprint/sprint_module.dart';
import 'package:social/app/shared/models/response_message_model.dart';
import 'package:social/app/shared/models/sprint_model.dart';

class SprintListWidget extends StatelessWidget {
  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();

  Widget _sprintTitle(SprintModel sprint, int index) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SprintTileWidget(sprint),
              Spacer(),
              IconButton(icon: const Icon(
                  Icons.delete_forever_rounded, size: 40,
                  color: Colors.redAccent),
                  onPressed: () => {_bloc.doDelete(sprint.id)}),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    _bloc.doFetch();
    return StreamBuilder
      (
        stream: _bloc.sprints,
        builder: (context, AsyncSnapshot<ResponseMessageModel> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.success) {
              final sprints = snapshot.data!.data;
              return ListView.separated
                (
                itemCount: sprints.length,
                itemBuilder: (_, index) {
                  final sprint = sprints[index];
                  return ListTile
                    (
                    title: _sprintTitle(sprint, index),
                    subtitle: Text(sprint.link),
                  );
                },
                separatorBuilder: (_, __) => Divider(),
              );
            }
            else {
              return Container(
                child: Center(
                  child: Text(snapshot.data!.message),
                ),
              );
            }
          }
          return StreamBuilder(
            stream: _bloc.loading,
            builder: (context, AsyncSnapshot<bool> snapshot)
            {
              final loading = snapshot.data ?? false;
              if (loading)
              {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          );
        },
    );
  }
}


