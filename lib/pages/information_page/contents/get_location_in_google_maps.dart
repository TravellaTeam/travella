import 'package:flutter/material.dart';
import 'package:travella_01/pages/information_page/constants.dart';

class GetLocationInGoogleMaps extends StatelessWidget {
  const GetLocationInGoogleMaps({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        print("tapped");
      },
      icon: CircleAvatar(
        backgroundColor: mainColor,
        child: Icon( //CONST YAPARSAN HATA VERİR!
            size: 28,
            color: Colors.white,
            Icons.alt_route),
      ),
    );
  }
}