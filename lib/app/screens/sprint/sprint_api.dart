import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:social/app/shared/models/response_message_model.dart';
import 'package:social/app/shared/models/sprint_holder.dart';
import 'package:social/app/shared/models/sprint_model.dart';
import 'package:social/app/shared/util/constants.dart';
import 'package:social/app_module.dart';

class SprintApi {
  final _client = AppModule.to.getDependency<Client>();

  Future<ResponseMessageModel> fetchSprints() async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint'));
    if (response.statusCode == 200) {
      final List<dynamic> jPosts = json.decode(response.body);
      final sprints = jPosts.map((s) => SprintModel.fromJson(s)).toList();
      final message = ResponseMessageModel(message: "Sprints baixadas...", success: true, data: sprints);
      return message;
    }else {
      return ResponseMessageModel(
          message: 'Erro ao recuperar sprints. Status code: ${response.statusCode}',
          success: false, data: List.generate(0, (index) => new SprintModel(id: index, nome: '', link: '')));
    }
  }

  Future<ResponseMessageModel> saveSprint(SprintHolder sprint) async {
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await _client.post(Uri.parse('${Constants.API_BASE_URL}/sprint'), headers: headers, body: sprintHolderToJson(sprint));
    if (response.statusCode > 200) {
      return ResponseMessageModel(
          message: 'Sprint ${sprint.nome} salva com sucesso!',
          success: true,
          data: sprint);
    } else {
      return ResponseMessageModel(
          message: 'Erro ao salvar a sprints ${sprint.nome}. Status code: ${response.statusCode}',
          success: false, data: List.generate(0, (index) => new SprintModel(id: 0, nome: '', link: '')));
    }
  }

  Future<ResponseMessageModel> fetchOneSprint(int id) async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/sprint/${id}'));
    if (response.statusCode >= 200) {
      final Map<String, dynamic> jPosts = json.decode(response.body);
      final SprintModel sprint = SprintModel.fromJson(jPosts);
      final message = ResponseMessageModel(message: "Sprint ${sprint.nome} baixada...", success: true, data: sprint);
      return message;
    } else {
      return ResponseMessageModel(
      message: 'Erro ao recuperar sprint ${id}. Status code: ${response.statusCode}',
      success: false, data: List.generate(0, (index) => new SprintModel(id: index, nome: '', link: '')));
      }
  }

  Future<ResponseMessageModel> deleteSprint(int id) async {
    final response = await _client.delete(Uri.parse('${Constants.API_BASE_URL}/sprint/${id}'));
    if (response.statusCode == 200) {
      final List<dynamic> jPosts = json.decode(response.body);
      final sprint = jPosts.map((s) => SprintModel.fromJson(s)).toList();
      return ResponseMessageModel(
          message: 'Sprint ID=${id} excluída com sucesso!',
          success: true,
          data: sprint);
    } else {
      return ResponseMessageModel(
          message: 'Erro ao excluir a sprints ${id}. Status code: ${response.statusCode}',
          success: false, data: List.generate(0, (index) => new SprintModel(id: 0, nome: '', link: '')));
    }
  }
}