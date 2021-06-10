// To parse this JSON data, do
//
//     final sprintModel = sprintModelFromJson(jsonString);

import 'dart:convert';

SprintModel sprintModelFromJson(String str) => SprintModel.fromJson(json.decode(str));

String sprintModelToJson(SprintModel data) => json.encode(data.toJson());

class SprintModel {
  SprintModel({
    required this.id,
    required this.nome,
    required this.link,
  });

  int id;
  String nome;
  String link;

  factory SprintModel.fromJson(Map<String, dynamic> json) => SprintModel(
    id: json["id"],
    nome: json["nome"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "link": link,
  };
}