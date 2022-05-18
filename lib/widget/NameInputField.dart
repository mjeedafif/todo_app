// ignore_for_file: file_names

import 'package:flutter/material.dart';

//Second part of profile screen
class NameInputField extends StatelessWidget {
  const NameInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 50),
          color: Colors.transparent,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Text('Your name',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    hintText: 'Enter your name',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
          alignment: Alignment.centerLeft),
    );
  }
}
