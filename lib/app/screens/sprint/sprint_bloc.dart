import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social/app/screens/sprint/sprint_api.dart';
import 'package:social/app/shared/models/response_message_model.dart';
import 'package:social/app/shared/models/sprint_holder.dart';
import 'package:social/app/shared/models/sprint_model.dart';


class SprintBloc extends BlocBase {
  final SprintApi _api;
  SprintBloc(this._api);

  final _sprintFetcher = PublishSubject<ResponseMessageModel>();
  final _loading = BehaviorSubject<bool>();

  Stream<ResponseMessageModel> get sprints => _sprintFetcher.stream;
  Stream<bool> get loading {
    return _loading.stream;
  }

  doFetch() async {
    _loading.sink.add(true);
    final response = await _api.fetchSprints();
    _loading.sink.add(false);
    _sprintFetcher.sink.add(response);
  }

  doFetchOne(int id) async {
    _loading.sink.add(true);
    final response = await _api.fetchOneSprint(id);
    _loading.sink.add(false);
    _sprintFetcher.sink.add(response);
  }

  doSave(SprintHolder sprint) async {
    _loading.sink.add(true);
    final response = await _api.saveSprint(sprint);
    _loading.sink.add(false);
    _sprintFetcher.sink.add(response);
  }

  doDelete(int id) async {
    _loading.sink.add(true);
    final response = await _api.deleteSprint(id);
    _loading.sink.add(false);
    _sprintFetcher.sink.add(response);
    this.doFetch();
  }

  @override
  void dispose() {
    _sprintFetcher.close();
    _loading.close();
    super.dispose();
  }

}
