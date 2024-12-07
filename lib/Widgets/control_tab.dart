// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_galaxy_task/services/lg_service.dart';
import 'package:liquid_galaxy_task/utils/constants/flyto_offsets.dart';
import 'package:provider/provider.dart';

class ControlTab extends StatelessWidget {
  const ControlTab({super.key});

  @override
  Widget build(BuildContext context) {
    final lgService = Provider.of<LgService>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        customListTile(
          text: 'Show Logo',
          icon: Icons.flag_outlined,
          onPressed: () async {
            String logo = await rootBundle.loadString('assets/kmls/logo.kml');
            lgService
                .execCommand("echo '$logo' > /var/www/html/kml/slave_3.kml");
            print(logo);
          },
        ),
        customListTile(
          text: 'KML: Lake Superior',
          icon: Icons.looks_one_outlined,
          onPressed: () async {
            // lgService.execCommand("> /var/www/html/kmls.txt");
            String content =
                await rootBundle.loadString('assets/kmls/lake_superior.kml');
            await lgService.sendFile(
                '/var/www/html/lake_superior.kml', content);
            await lgService.execCommand(
                'echo "http://lg1:81/lake_superior.kml" > /var/www/html/kmls.txt');
            await lgService.execCommand(
                'echo "flytoview=$lake_superior_offset" > /tmp/query.txt');
          },
        ),
        customListTile(
          text: 'KML: Kerguelen Islands',
          icon: Icons.looks_two_outlined,
          onPressed: () async {
            String content =
                await rootBundle.loadString('assets/kmls/island_kerguelen.kml');
            await lgService.sendFile(
                '/var/www/html/island_kerguelen.kml', content);
            await lgService.execCommand(
                'echo "http://lg1:81/island_kerguelen.kml" > /var/www/html/kmls.txt');
            await lgService.execCommand(
                'echo "flytoview=$island_kerguelen_offset" > /tmp/query.txt');
          },
        ),
        customListTile(
          text: 'Clear Logo',
          icon: Icons.signal_cellular_no_sim_outlined,
          onPressed: () async {
            String clear =
                await rootBundle.loadString('assets/kmls/clear_logo.kml');
            await lgService
                .execCommand("echo '$clear' > /var/www/html/kml/slave_3.kml");
            print('Clear Logo button pressed');
          },
        ),
        customListTile(
          text: 'Clear KML',
          icon: Icons.cancel_outlined,
          onPressed: () async {
            await lgService.execCommand('> /var/www/html/kmls.txt');

            print('Clear KML');
          },
        ),
      ],
    );
  }
}

Widget customButton({required String text, required Function onPressed}) {
  return ElevatedButton(
    onPressed: () {
      onPressed();
    },
    style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
    child: Text(
      text,
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget customListTile(
    {required String text,
    required IconData icon,
    required Function onPressed}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(text),
    onTap: () {
      onPressed();
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
  );
}
