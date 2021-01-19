import 'Company.dart';
import 'Invite.dart';
import 'User.dart';

abstract class IUserWs {
  // COMPANY
  Future<Company> createCompany(String name, String address);

  Future<List<Company>> findAllCompanies();

  Future<Company> findCompanyById(int companyId);

  Future<bool> deleteCompany(int companyId);

  // INVITE
  Future<Invite> createInvite(String email, int companyId, List<String> roles);

  Future<List<Invite>> findInvitesByCompany(int companyId);

  Future<User> acceptInvite(int inviteId, int companyId, String password);

  Future<bool> deleteInvite(int inviteId, int companyId, bool declineOrDelete);

  // USER
  Future<List<User>> findUsersByCompany(int companyId);

  Future<User> findUserByCredentials(String email, String password);

  Future<User> findUserById(int userId, int companyId);

  Future<User> updateUserPassword(
      int userId, int companyId, String oldPassword, String newPassword);

  Future<bool> deleteUser(int userId, int companyId);
}
