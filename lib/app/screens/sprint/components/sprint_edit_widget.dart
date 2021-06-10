import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social/app/screens/sprint/sprint_bloc.dart';
import 'package:social/app/screens/sprint/sprint_module.dart';
import 'package:social/app/shared/models/response_message_model.dart';
import 'package:social/app/shared/models/sprint_holder.dart';
import 'package:social/app/shared/models/sprint_model.dart';

class SprintEditWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SprintEditWidgetState();
  }
}

class SprintEditWidgetState extends State<SprintEditWidget> {
  late final SprintBloc _bloc = SprintModule.to.getBloc<SprintBloc>();

  late SprintHolder sprint = new SprintHolder(link: '', nome: '');
  int? _value;
  List<SprintModel> items = [];
  TextEditingController formTitleCtrl = TextEditingController(text: "");
  TextEditingController formLinkCtrl = TextEditingController(text: "");
  int? _editingId;
  final _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    _value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc.doFetch();
    return StreamBuilder
    (
      stream: _bloc.sprints,
      builder: (context, AsyncSnapshot<ResponseMessageModel> snapshot)
      {
      if (snapshot.hasData)
      {
        if (snapshot.data!.data is List<SprintModel>) {
          items.clear();
          items.add(new SprintModel(id: 0, nome: 'Clique aqui', link: ''));
          items.addAll(snapshot.data!.data) ;
      } else if (snapshot.data!.data is SprintModel) {
          SprintModel gottenSprint = snapshot.data!.data;
          formTitleCtrl.text = gottenSprint.nome;
          formLinkCtrl.text = gottenSprint.link;
          _editingId = gottenSprint.id;
        }
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Column
            (
              children:
              [
                Text(
                  "Selecione uma SPRINT para editar",
                    style: const
                    TextStyle(
                  fontSize: 20,
                ),
                    ),
                DropdownButton<int>
                (
                  value: _value,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (int? newValue) {
                    setState(() {
                      _value = newValue!;
                      _bloc.doFetchOne(_value!);
                    });
                  },
                  items: items
                      .map<DropdownMenuItem<int>>((SprintModel sprint) {
                    return DropdownMenuItem<int>(
                      value: sprint.id,
                      child: Text("Sprint: " + sprint.nome),
                    );
                  }).toList(),
                )
            ])
          ]
        ),
        Row
        (
          children:
          [
            Expanded( child: Form
              (
                key: _formKey2,
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
                        labelText: 'Nome da Sprint *',
                      ),
                        controller: formTitleCtrl,
                        validator: (value)
                        {
                          if (value == null || value.isEmpty)
                          {
                            return 'O nome da Sprint é obrigatório';
                          }
                          return null;
                        },
                        onSaved: (value) => sprint.nome = value!
                    ),
                    TextFormField
                    (
                      decoration: const InputDecoration
                        (
                          icon: Icon(Icons.link),
                          hintText: 'http://sitedasprint.com.br/codigo',
                          labelText: 'Link para acessar a sprint *'

                      ),
                      controller: formLinkCtrl,
                      validator: (String? value2) {
                        bool validUrl = Uri.parse(value2!).isAbsolute;
                        if (value2 == null || value2.isEmpty)
                        {
                          return 'O site da Sprint é obrigatório';
                        }
                        else if (validUrl)
                        {
                          return 'Deve ser um link!';
                        }
                        return null;
                      },
                      onSaved: (value2) => sprint.link = '${value2!}',
                    ),
                  ],

                )
            )
            )
          ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () =>
              {
                if (_formKey2.currentState!.validate())
                  {
                    _formKey2.currentState!.save(),
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(
                        'Não é possível editar as SPRINTS, fiz essa tela por puro SHOWOFF!')))
                  }
                else
                  {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(
                        'Corrija os erros no formulário por favor!')))
                  }
              } , child: Text("Salvar"))
            ],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
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
      )
              ],
            )
        ],
        );
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
      }
    );
  }
}