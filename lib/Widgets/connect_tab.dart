import 'package:flutter/material.dart';
import 'package:liquid_galaxy_task/services/lg_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectTab extends StatefulWidget {
  const ConnectTab({super.key});

  @override
  State<ConnectTab> createState() => _ConnectTabState();
}

class _ConnectTabState extends State<ConnectTab> {
  bool isConnected = false;
  final TextEditingController hostController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberOfMachinesController =
      TextEditingController();

  @override
  void dispose() {
    hostController.dispose();
    portController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    numberOfMachinesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lgService = Provider.of<LgService>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            isConnected
                ? Row(
                    children: [
                      Text("Status: ", style: TextStyle(fontSize: 22)),
                      Text("Connected",
                          style: TextStyle(fontSize: 22, color: Colors.green)),
                      SizedBox(width: 8),
                      Icon(Icons.circle, color: Colors.green),
                    ],
                  )
                : Row(
                    children: [
                      Text("Status: ", style: TextStyle(fontSize: 22)),
                      Text("Disconnected",
                          style: TextStyle(fontSize: 22, color: Colors.red)),
                      SizedBox(width: 8),
                      Icon(Icons.circle, color: Colors.red),
                    ],
                  ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Host',
                border: OutlineInputBorder(),
              ),
              controller: hostController,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Port',
                border: OutlineInputBorder(),
              ),
              controller: portController,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              controller: usernameController,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Number of Machines',
                border: OutlineInputBorder(),
              ),
              controller: numberOfMachinesController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                lgService.host = hostController.text;
                lgService.port = int.parse(portController.text);
                lgService.username = usernameController.text;
                lgService.password = passwordController.text;
                lgService.rigs = int.parse(numberOfMachinesController.text);

                prefs.setString('host', lgService.host);
                prefs.setInt('port', lgService.port);
                prefs.setString('username', lgService.username);
                prefs.setString('password', lgService.password);
                prefs.setInt('rigs', lgService.rigs);

                bool res = await lgService.checkConnection();
                setState(() {
                  isConnected = res;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(res ? 'Connected' : 'Failed to connect'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0))),
              child: const Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
