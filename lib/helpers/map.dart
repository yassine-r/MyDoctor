import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyMapLauncher {
  static openMapsSheet(context, titl, latitude, longitude) async {
    try {
      // final coords = Coords(37.759392, -122.5107336);
      final coords = Coords(latitude, longitude);
      final title = titl;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: SvgPicture.asset(
                          map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
