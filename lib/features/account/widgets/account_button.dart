// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.black12.withOpacity(0.03),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
          onPressed: onTap,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
