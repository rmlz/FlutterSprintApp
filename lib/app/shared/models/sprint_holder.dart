// To parse this JSON data, do
//
//     final SprintHolder = SprintHolderFromJson(jsonString);

import 'dart:convert';

SprintHolder sprintHolderFromJson(String str) => SprintHolder.fromJson(json.decode(str));

String sprintHolderToJson(SprintHolder data) => json.encode(data.toJson());

class SprintHolder {
  SprintHolder({
    required this.nome,
    required this.link,
  });

  String nome;
  String link;

  factory SprintHolder.fromJson(Map<String, dynamic> json) => SprintHolder(
    nome: json["nome"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "nome": nome,
    "link": link,
  };
}