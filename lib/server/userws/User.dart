class User {
  final int id;
  final String email;
  final String password;
  final int companyId;
  final List<String> roles;

  User(this.id, this.email, this.password, this.companyId, this.roles);
}
