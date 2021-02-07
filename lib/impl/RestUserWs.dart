import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:proximapp/server/userws/Company.dart';
import 'package:proximapp/server/userws/IUserWs.dart';
import 'package:proximapp/server/userws/Invite.dart';
import 'package:proximapp/server/userws/User.dart';

class RestUserWs implements IUserWs {
  static var client = http.Client();
  static const timeoutDuration = Duration(seconds: 5);
  String server;

  RestUserWs(this.server);

  // COMPANY
  @override
  Future<Company> createCompany(String name, String address) async {
    try {
      Response response = await client.post(server + '/companies', body: {
        'name': name,
        'address': address
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      int companyId = jsonObj['id'];
      String companyName = jsonObj['name'];
      String companyAddress = jsonObj['address'];
      return Company(companyId, companyName, companyAddress);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Company>> findAllCompanies() async {
    try {
      List<Company> companies = List();
      Response response = await client
          .get(server + '/companies')
          .timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonList = jsonDecode(response.body);
      for (var jsonObj in jsonList) {
        int companyId = jsonObj['id'];
        String companyName = jsonObj['name'];
        String companyAddress = jsonObj['address'];
        Company company = Company(companyId, companyName, companyAddress);
        companies.add(company);
      }
      return companies;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Company> findCompanyById(int companyId) async {
    try {
      Response response = await client
          .get(server + '/companies/$companyId')
          .timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      int compId = jsonObj['id'];
      String companyName = jsonObj['name'];
      String companyAddress = jsonObj['address'];
      return Company(compId, companyName, companyAddress);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteCompany(int companyId) async {
    try {
      Response response = await client
          .delete(server + '/companies/$companyId')
          .timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      return response.body == 'true';
    } catch (e) {
      return false;
    }
  }

  // INVITE
  @override
  Future<Invite> createInvite(
      String email, int companyId, List<String> roles) async {
    try {
      Response response = await client.post(server + '/invites/$companyId',
          body: {
            'email': email,
            'roles': roles.join(',')
          }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      int inviteId = jsonObj['id'];
      String inviteEmail = jsonObj['email'];
      int inviteCompanyId = jsonObj['companyId'];
      List<String> inviteRoles = [];
      for (var role in jsonObj['roles']) roles.add(role);
      return Invite(inviteId, inviteEmail, inviteCompanyId, inviteRoles);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Invite>> findInvitesByCompany(int companyId) async {
    try {
      List<Invite> invites = List();
      Response response = await client
          .get(server + '/invites/$companyId/query')
          .timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonList = jsonDecode(response.body);
      for (var jsonObj in jsonList) {
        int inviteId = jsonObj['id'];
        String inviteEmail = jsonObj['email'];
        int inviteCompanyId = jsonObj['companyId'];
        List<String> roles = [];
        for (var role in jsonObj['roles']) roles.add(role);
        Invite invite =
            new Invite(inviteId, inviteEmail, inviteCompanyId, roles);
        invites.add(invite);
      }
      return invites;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> acceptInvite(
      int inviteId, int companyId, String password) async {
    try {
      Response response = await client
          .put(server + '/invites/$companyId/$inviteId', body: {
        'accept_or_not': 'accept',
        'password': password
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      int userId = jsonObj['id'];
      String userEmail = jsonObj['email'];
      String userPassword = jsonObj['password'];
      int userCompanyId = jsonObj['companyId'];
      List<String> roles = [];
      for (var role in jsonObj['roles']) roles.add(role);
      return User(userId, userEmail, userPassword, userCompanyId, roles);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteInvite(
      int inviteId, int companyId, bool declineOrDelete) async {
    try {
      Response response = await client
          .put(server + '/invites/$companyId/$inviteId', body: {
        'accept_or_not': 'not'
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      return response.body == 'true';
    } catch (e) {
      return false;
    }
  }

  // USER
  @override
  Future<List<User>> findUsersByCompany(companyId) async {
    try {
      List<User> users = [];
      Response response = await client
          .get(server + '/users/$companyId')
          .timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonList = jsonDecode(response.body);
      for (var jsonObj in jsonList) {
        int userId = jsonObj['id'];
        String userEmail = jsonObj['email'];
        String userPassword = jsonObj['password'];
        int userCompanyId = jsonObj['companyId'];
        List<String> userRoles = [];
        for (var role in jsonObj['roles']) userRoles.add(role);
        User user =
            new User(userId, userEmail, userPassword, userCompanyId, userRoles);
        users.add(user);
      }
      return users;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> findUserByCredentials(String email, String password) async {
    try {
      Response response = await client.post(server + '/users/login', body: {
        'email': email,
        'password': password
      }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      int userId = jsonObj['id'];
      String userEmail = jsonObj['email'];
      String userPassword = jsonObj['password'];
      int userCompanyId = jsonObj['companyId'];
      List<String> userRoles = [];
      for (var role in jsonObj['roles']) userRoles.add(role);
      return User(userId, userEmail, userPassword, userCompanyId, userRoles);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> findUserById(int userId, int companyId) async {
    try {
      Response response = await client
          .get(server + '/users/$companyId/$userId')
          .timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      int userUid = jsonObj['id'];
      String userEmail = jsonObj['email'];
      String userPassword = jsonObj['password'];
      int userCompanyId = jsonObj['companyId'];
      List<String> userRoles = [];
      for (var role in jsonObj['roles']) userRoles.add(role);
      return User(userUid, userEmail, userPassword, userCompanyId, userRoles);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> updateUserPassword(
      int userId, int companyId, String oldPassword, String newPassword) async {
    try {
      Response response = await client.put(server + '/users/$companyId/$userId',
          body: {
            'old_password': oldPassword,
            'new_password': newPassword
          }).timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      var jsonObj = jsonDecode(response.body);
      int uId = jsonObj['id'];
      String userEmail = jsonObj['email'];
      String userPassword = jsonObj['password'];
      int userCompanyId = jsonObj['companyId'];
      List<String> userRoles = [];
      for (var role in jsonObj['roles']) userRoles.add(role);
      return User(uId, userEmail, userPassword, userCompanyId, userRoles);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteUser(int userId, int companyId) async {
    try {
      Response response = await client
          .delete(server + '/users/$companyId/$userId')
          .timeout(timeoutDuration, onTimeout: () => throw 'timeout');
      return response.body == 'true';
    } catch (e) {
      return false;
    }
  }
}
