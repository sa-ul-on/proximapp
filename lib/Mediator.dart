import 'BLEManager.dart';
import 'LoginData.dart';
import 'SessionManager.dart';
import 'model/Annuncio.dart';
import 'server/userws/IUserWs.dart';
import 'server/userws/User.dart';
import 'server/worktimews/IGatheringWs.dart';
import 'server/worktimews/Worktime.dart';

class Mediator {
  BLEManager bleManager;

  void init() async {
    // WidgetsFlutterBinding.ensureInitialized();
    bleManager = BLEManager();
    bleManager.setCallback(_notifyGathering);
    // Init user side
    await sessionManager.init();
    if (sessionManager.isUserLogged()) {
      LoginData loginData = await sessionManager.getLoggedUser();
      User user =
          await userWs.findUserById(loginData.userId, loginData.companyId);
      if (user != null) {
        loginData.userId = user.id;
        loginData.companyId = user.companyId;
        loginData.email = user.email;
        loginData.roles = user.roles;
        await sessionManager.setLoggedUser(loginData);
      } else {
        await sessionManager.removeLoggedUser();
      }
    }
    // Init worktime side
    if (sessionManager.isUserLogged()) {
      LoginData loginData = await sessionManager.getLoggedUser();
      List<Worktime> worktimes = await worktimeWs.findWorktimesByQuery(
          loginData.companyId, null, null, [loginData.userId]);
      if (worktimes != null && worktimes.isNotEmpty) {
        if (worktimes[0].dateTo == null) {
          worktime = worktimes[0];
        }
      }
    }
  }

  void _notifyGathering(int secondTrackingId, double distance) async {
    print('assembramento in corso...');
    /*
    int pid = 1;
    LoginData loginData = await sessionManager.getLoggedUser();
    var now = DateTime.now();
    gatheringWs.notifyGathering(loginData.companyId, loginData.userId,
        secondTrackingId, pid, distance, now);
    */
  }

  getBleManager() {
    return null;
  }

  List<Annuncio> getAnnunci() {
    List<Annuncio> msgs = [
      Annuncio(
          'In sala riunioni ci sono le pizzette per San Raffaele!',
          DateTime.parse('2020-10-26 09:42:27'),
          'Raffaele Contabile',
          Annuncio.INFO),
      Annuncio(
          'Conte ci ha chiuso statevi a casa fino a lunedì',
          DateTime.parse('2020-04-15 21:23:14'),
          'Gaetano Gallo',
          Annuncio.ALERT),
      Annuncio('Quarantena per il reparto NoSQL',
          DateTime.parse('2020-04-02 20:35:44'), 'Mario Russo', Annuncio.URGENT)
    ];
    return msgs;
  }

  //////////////////////////////////  USER WS //////////////////////////////////
  IUserWs userWs;
  SessionManager sessionManager = SessionManager();

  void setUserWs(IUserWs userWs) {
    this.userWs = userWs;
  }

  bool isUserLogged() {
    return sessionManager.isUserLogged();
  }

  Future<bool> doLogin(String email, String password) async {
    User user = await userWs.findUserByCredentials(email, password);
    if (user != null) {
      LoginData loginData =
          LoginData(user.id, user.companyId, user.email, user.roles);
      await sessionManager.setLoggedUser(loginData);
      return true;
    } else {
      await sessionManager.removeLoggedUser();
      return false;
    }
  }

  void doLogout() async {
    await sessionManager.removeLoggedUser();
  }

  ////////////////////////////  WORKTIME MANAGEMENT ////////////////////////////
  IWorktimeWs worktimeWs;
  Worktime worktime;

  void setWorktimeWs(IWorktimeWs worktimeWs) {
    this.worktimeWs = worktimeWs;
  }

  bool isWorktimeOpen() {
    return worktime != null;
  }

  Future<bool> openWorktime() async {
    if (isUserLogged() && !isWorktimeOpen()) {
      LoginData loginData = await sessionManager.getLoggedUser();
      var newWorktime = await worktimeWs.notifyWorktime(
          loginData.userId, loginData.companyId, DateTime.now(), true);
      // TODO: trackingId
      if (newWorktime == null || newWorktime.dateTo != null) {
        return false;
      }
      bleManager.startBroadcastAndScan(loginData.userId);
      // Ok
      worktime = newWorktime;
    } else {
      print('worktime already open');
    }
    return true;
  }

  Future<bool> closeWorktime() async {
    if (isWorktimeOpen()) {
      await bleManager.stopBroadcastAndScan();
      LoginData loginData = await sessionManager.getLoggedUser();
      var newWorktime = await worktimeWs.notifyWorktime(
          loginData.userId, loginData.companyId, DateTime.now(), false);
      if (newWorktime == null || newWorktime.dateTo == null) {
        return false;
      }
      worktime = null;
    } else {
      print('no worktime available');
    }
    return true;
  }
}
