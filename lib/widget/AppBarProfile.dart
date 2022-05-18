// ignore_for_file: file_names

import 'package:flutter/material.dart';

//First part of profile screen
class AppBarContainer extends StatelessWidget {
  const AppBarContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
            ),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 50,
                child: Text(
                  'A',
                  style: TextStyle(fontSize: 64, color: Colors.black),
                ),
              ),
            ),
          ),
          Container(
            height: 92,
            color: Colors.transparent,
            child: SizedBox(
              width: 350,
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Text(
                      'Welcome, \nAbdulmajid',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // const Spacer(),
                  // Card(
                  //   color: Colors.white,
                  //   shape: const CircleBorder(),
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(Icons.save),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
