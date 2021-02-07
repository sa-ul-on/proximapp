import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:proximapp/server/worktimews/IGatheringWs.dart';
import 'package:proximapp/server/worktimews/Worktime.dart';

class RestWorktimeWs implements IWorktimeWs {
  static var client = http.Client();
  static const timeoutDuration = Duration(seconds: 5);
  static DateFormat formatter = DateFormat('yyyy-MM-dd kk:mm:ss');
  String server;

  RestWorktimeWs(this.server);

  @override
  Future<Worktime> notifyWorktime(
      int userId, int companyId, DateTime datetime, bool inOrOut) async {
    try {
      Response response =
          await client.post(server + '/worktimes/$companyId', body: {
        'user_id': userId.toString(),
        'date': formatter.format(datetime),
        'in_or_out': inOrOut.toString()
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      int id = jsonObj['id'];
      DateTime dateFrom = DateTime.parse(jsonObj['dateFrom']);
      DateTime dateTo =
          jsonObj['dateTo'] != null ? DateTime.parse(jsonObj['dateTo']) : null;
      int pUserId = jsonObj['userId'];
      int pCompanyId = jsonObj['companyId'];
      return Worktime(id, dateFrom, dateTo, pCompanyId, pUserId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Worktime>> findWorktimesByQuery(int companyId, DateTime dateFrom,
      DateTime dateTo, List<int> userIds) async {
    try {
      String url = server + '/worktimes/$companyId/query';
      List<String> params = List();
      if (dateFrom != null)
        params.add('date_from=' + formatter.format(dateFrom));
      if (dateTo != null) params.add('date_to=' + formatter.format(dateTo));
      if (userIds != null) params.add('user_ids=' + userIds.join(','));
      if (params.isNotEmpty) url += '?' + params.join('&');
      Response response = await client
          .get(url)
          .timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonList = jsonDecode(response.body);
      List<Worktime> worktimes = List();
      for (var jsonObj in jsonList) {
        int id = jsonObj['id'];
        DateTime dateFrom = DateTime.parse(jsonObj['dateFrom']);
        DateTime dateTo = jsonObj['dateTo'] != null
            ? DateTime.parse(jsonObj['dateTo'])
            : null;
        int pUserId = jsonObj['userId'];
        int pCompanyId = jsonObj['companyId'];
        Worktime worktime = Worktime(id, dateFrom, dateTo, pCompanyId, pUserId);
        worktimes.add(worktime);
      }
      return worktimes;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteWorktime(int worktimeId, int companyId) async {
    try {
      Response response = await client
          .delete(server + '/worktimes/$companyId/$worktimeId')
          .timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      return response.body == 'true';
    } catch (e) {
      return false;
    }
  }
}
