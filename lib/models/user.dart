class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String nom;
  final String prenom;
  final String? avatar;

  AppUserData({required this.uid, required this.nom, required this.prenom, required this.avatar});
}