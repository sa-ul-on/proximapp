import 'BLEManager.dart';
import 'LoginData.dart';
import 'SessionManager.dart';
import 'model/Annuncio.dart';
import 'server/userws/IUserWs.dart';
import 'server/userws/User.dart';
import 'server/worktimews/IGatheringWs.dart';

class Mediator {
  BLEManager bleManager;

  void init() {
    print("initing in splash screen...");
    // WidgetsFlutterBinding.ensureInitialized();
    bleManager = BLEManager();
    initUserSide();
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

  void initUserSide() async {
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
  }

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
  bool worktimeRunning = false;
  IWorktimeWs worktimeWs;

  void setWorktimeWs(IWorktimeWs worktimeWs) {
    this.worktimeWs = worktimeWs;
  }

  bool isWorktimeOpen() {
    return worktimeRunning;
  }

  void openWorktime() {
    if (!worktimeRunning) {
      // worktimeWs.notifyWorktime(userId, companyId, datetime, inOrOut);
      /*await bleManager.init();
    print("INIT DONE");
    await bleManager.beaconBroadcast.start(); // inizio il broadcasting
    print(bleManager.beaconBroadcast.isAdvertising());

    bleManager.lookAround();

    // inizio lo scanning

    bleManager.flutterBlue.startScan();
    print("Scan for devices Started");*/
      worktimeRunning = true;
      print('open worktime');
    } else {
      print('worktime already open');
    }
  }

  void closeWorktime() {
    if (worktimeRunning) {
      /*var bleManager = widget.bleManager;

    await bleManager.beaconBroadcast.stop(); // stop broadcasting
    print("broadcasting stop");
    await bleManager.flutterBlue.stopScan(); //stop scanning
    print("monitoring stopped");

    print(bleManager.beaconBroadcast.isAdvertising());*/
      worktimeRunning = false;
      print('close worktime');
    } else {
      print('no worktime available');
    }
  }
}
