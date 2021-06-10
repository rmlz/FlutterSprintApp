import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/sprint/sprint_bloc.dart';
import 'package:social/app/screens/sprint/sprint_module.dart';
import 'package:social/app/shared/models/response_message_model.dart';
import 'package:social/app/shared/models/sprint_holder.dart';

class SprintFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SprintFormWidgetState();
  }
}

class SprintFormWidgetState extends State<SprintFormWidget> {
  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();

  final _formKey = GlobalKey<FormState>();
  late SprintHolder sprint = new SprintHolder(link: '', nome: '');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder
      (
        stream: _bloc.sprints,
        builder: (context, AsyncSnapshot<ResponseMessageModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Center(
                  child: Text(snapshot.data!.message)
              )
            );
          }
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Form
              (
              key: _formKey,
              child: Column
                (
                children:
                [
                  TextFormField
                    (
                    decoration: const InputDecoration
                      (
                        icon: Icon(Icons.title),
                        hintText: 'Sprint 256 - Development',
                        labelText: 'Nome da Sprint *'

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'O nome da Sprint é obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value) => sprint.nome = value!,
                  ),

                  TextFormField
                    (
                    decoration: const InputDecoration
                      (
                        icon: Icon(Icons.link),
                        hintText: 'sitedasprint.com.br/codigo',
                        labelText: 'Link para acessar a sprint *',
                        prefixText: 'https://www.'

                    ),
                    validator: (value2) {
                      if (value2 == null || value2.isEmpty) {
                        return 'O site da da Sprint é obrigatório';
                      }
                      return null;
                    },
                    onSaved: (value2) => sprint.link = 'https://www.${value2!}',
                  ),
                  ElevatedButton(onPressed: () =>
                  {
                    if (_formKey.currentState!.validate())
                      {
                        _formKey.currentState!.save(),
                        _bloc.doSave(sprint),
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(
                            'Salvando Sprint Nome: ${sprint.nome} Link: ${sprint
                                .link}...')))
                      }
                    else
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(
                            'Corrija os erros no formulário por favor!')))
                      }
                  },

                    child: Text('Salvar'),
                  )

                ],
              ),
            )
              ]
            );
          }
            return StreamBuilder(
              stream: _bloc.loading,
              builder: (context, AsyncSnapshot<bool> snapshot) {
                var loading = snapshot.data ?? false;
                if (snapshot.data == null) {
                  loading = true;
                }
                if (loading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            );
          }
    );
  }
}