import 'package:flutter/material.dart';

//Widgets
import '../widget/NameInputField.dart';
import '../widget/AppBarProfile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AppBarContainer(),
        NameInputField(),
      ],
    );
  }
}
