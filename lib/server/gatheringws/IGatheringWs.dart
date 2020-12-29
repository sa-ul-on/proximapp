import 'Gathering.dart';
import 'Place.dart';
import 'Tracking.dart';

abstract class IGatheringWs {
  // GATHERING
  Future<Gathering> notifyGathering(int companyId, int t1id, int t2id, int pid,
      double dist, DateTime datetime);

  Future<List<Gathering>> findGatheringsByQuery(
      int companyId,
      DateTime dateFrom,
      DateTime dateTo,
      List<int> trackingIds,
      List<int> placeIds);

  Future<bool> deleteGathering(int gatheringId, int companyId);

  // PLACE
  Future<Place> createPlace(String name, int companyId);

  Future<List<Place>> findPlacesByCompany(int companyId);

  Future<Place> findPlaceById(int placeId, int companyId);

  Future<bool> deletePlace(int placeId, int companyId);

  // TRACKING
  Future<Tracking> createTracking(String firstname, String lastname,
      String address, String hicard, String phone, int userId, int companyId);

  Future<List<Tracking>> findTrackingsByCompany(int companyId);

  Future<Tracking> findTrackingById(int trackingId, int companyId);

  Future<bool> deleteTracking(int trackingId, int companyId);
}
