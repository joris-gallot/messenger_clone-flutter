class User {
  String firstname;
  String lastname;
  String image;

  User(user) {
    this.image = user["picture"]["large"];
    this.firstname = user["name"]["first"];
    this.lastname = user["name"]["last"];
  }
}
