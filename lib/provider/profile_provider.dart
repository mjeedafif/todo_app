enum Gender {
  male,
  female,
}

class Profile {
  final String name;
  final Gender? gender;

  Profile({required this.name, this.gender});
}
