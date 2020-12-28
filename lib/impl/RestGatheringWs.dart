import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:proximapp/server/gatheringws/Gathering.dart';
import 'package:proximapp/server/gatheringws/IGatheringWs.dart';
import 'package:proximapp/server/gatheringws/Place.dart';
import 'package:proximapp/server/gatheringws/Tracking.dart';

class RestGatheringWs implements IGatheringWs {
  static String server = 'http://10.0.2.2:8080'; // "localhost" alias for ADV
  static var client = http.Client();

  // GATHERING
  @override
  Future<bool> notifyGathering(int companyId, int t1id, int t2id, int pid,
      double dist, DateTime datetime) async {
    // TODO: implement notifyGathering
    throw UnimplementedError();
  }

  @override
  Future<List<Gathering>> findGatheringsByCompany(int companyId) async {
    // TODO: implement findGatheringsByCompany
    throw UnimplementedError();
  }

  @override
  Future<List<Gathering>> findGatheringsByQuery(
      int companyId,
      DateTime dateFrom,
      DateTime dateTo,
      List<int> trackingIds,
      List<int> placeIds) {
    // TODO: implement findGatheringsByQuery
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteGathering(int gatheringId, int companyId) {
    // TODO: implement deleteGathering
    throw UnimplementedError();
  }

  // PLACE
  @override
  Future<Place> createPlace(String name, int companyId) async {
    try {
      Response response = await client
          .post(server + '/places/$companyId', body: {'name': name});
      var jsonObj = jsonDecode(response.body);
      int pId = jsonObj['id'];
      String pName = jsonObj['name'];
      int pCompanyId = jsonObj['companyId'];
      return Place(pId, pName, pCompanyId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Place>> findPlacesByCompany(int companyId) async {
    try {
      List<Place> places = List();
      Response response = await client.get(server + '/places/$companyId');
      var jsonList = jsonDecode(response.body);
      for (var jsonObj in jsonList) {
        int id = jsonObj['id'];
        String name = jsonObj['name'];
        int companyId = jsonObj['companyId'];
        Place place = Place(id, name, companyId);
        places.add(place);
      }
      return places;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Place> findPlaceById(int placeId, int companyId) async {
    try {
      Response response =
          await client.get(server + '/places/$companyId/$placeId');
      var jsonPlace = jsonDecode(response.body);
      int pId = jsonPlace['id'];
      String pName = jsonPlace['name'];
      int pCompanyId = jsonPlace['companyId'];
      return Place(pId, pName, pCompanyId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deletePlace(int placeId, int companyId) async {
    try {
      Response response =
          await client.delete(server + '/places/$companyId/$placeId');
      return response.body == 'true';
    } catch (e) {
      return false;
    }
  }

  // TRACKING
  @override
  Future<Tracking> createTracking(
      String firstname,
      String lastname,
      String address,
      String hicard,
      String phone,
      int userId,
      int companyId) async {
    try {
      Response response =
          await client.post(server + '/trackings/$companyId', body: {
        'firstname': firstname,
        'lastname': lastname,
        'address': address,
        'hicard': hicard,
        'phone': phone,
        'user_id': userId.toString()
      });
      var jsonObj = jsonDecode(response.body);
      int tId = jsonObj['id'];
      String tFirstname = jsonObj['firstname'];
      String tLastname = jsonObj['lastname'];
      String tAddress = jsonObj['address'];
      String tHicard = jsonObj['hicard'];
      String tPhone = jsonObj['phone'];
      int tUserId = jsonObj['userId'];
      int tCompanyId = jsonObj['companyId'];
      return Tracking(tId, tFirstname, tLastname, tAddress, tHicard, tPhone,
          tUserId, tCompanyId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Tracking>> findTrackingsByCompany(int companyId) async {
    try {
      List<Tracking> trackings = List();
      Response response = await client.get(server + '/trackings/$companyId');
      var jsonList = jsonDecode(response.body);
      for (var jsonObj in jsonList) {
        int tId = jsonObj['id'];
        String tFirstname = jsonObj['firstname'];
        String tLastname = jsonObj['lastname'];
        String tAddress = jsonObj['address'];
        String tHicard = jsonObj['hicard'];
        String tPhone = jsonObj['phone'];
        int tUserId = jsonObj['userId'];
        int tCompanyId = jsonObj['companyId'];
        Tracking tracking = Tracking(tId, tFirstname, tLastname, tAddress,
            tHicard, tPhone, tUserId, tCompanyId);
        trackings.add(tracking);
      }
      return trackings;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Tracking> findTrackingById(int trackingId, int companyId) async {
    try {
      Response response =
          await client.get(server + '/trackings/$companyId/$trackingId');
      var jsonObj = jsonDecode(response.body);
      int tId = jsonObj['id'];
      String tFirstname = jsonObj['firstname'];
      String tLastname = jsonObj['lastname'];
      String tAddress = jsonObj['address'];
      String tHicard = jsonObj['hicard'];
      String tPhone = jsonObj['phone'];
      int tUserId = jsonObj['userId'];
      int tCompanyId = jsonObj['companyId'];
      return Tracking(tId, tFirstname, tLastname, tAddress, tHicard, tPhone,
          tUserId, tCompanyId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> deleteTracking(int trackingId, int companyId) async {
    try {
      Response response =
          await client.delete(server + '/trackings/$companyId/$trackingId');
      return response.body == 'true';
    } catch (e) {
      return false;
    }
  }
}
