import 'Worktime.dart';

abstract class IWorktimeWs {
  Future<Worktime> notifyWorktime(
      int userId, int companyId, DateTime datetime, bool inOrOut);

  Future<List<Worktime>> findWorktimesByQuery(
      int companyId, DateTime dateFrom, DateTime dateTo, List<int> userIds);

  Future<bool> deleteWorktime(int worktimeId, int companyId);
}
