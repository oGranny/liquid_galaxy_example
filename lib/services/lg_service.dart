import 'dart:io';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:path_provider/path_provider.dart';

class LgService {
  String host = "";
  int port = 22;
  String username = "lg";
  String password = "lg";
  int rigs = 3;

  Future<File> _createFile(String name, String content) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    file.writeAsStringSync(content);
    return file;
  }

  Future<bool> checkConnection() async {
    try {
      final socket = await SSHSocket.connect(host, port);
      SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );
      print('Connected to $host:$port');
      return true;
    } catch (e) {
      print('Failed to connect to $host:$port, $e');
      return false;
    }
  }

  Future<LgService> execCommand(String command) async {
    try {
      final socket = await SSHSocket.connect(host, port);
      final client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );
      await client.execute(command);
      // ignore: avoid_print
      print('Command sent to $host:$port');
    } catch (e) {
      print('Failed to send command to $host:$port, $e');
    } finally {
      return this;
    }
  }

  Future<LgService> sendFile(String remoteFilepath, String content) async {
    try {
      final socket = await SSHSocket.connect(host, port);
      final client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );

      final sftp = await client.sftp();

      final file = await sftp.open(
        remoteFilepath,
        mode: SftpFileOpenMode.truncate |
            SftpFileOpenMode.create |
            SftpFileOpenMode.write,
      );
      // print(content);
      final currentFile =
          await _createFile(remoteFilepath.split('/').last, content);
      final fileStream = currentFile.openRead();
      int offset = 0;

      await for (final chunk in fileStream) {
        final typedChunk = Uint8List.fromList(chunk);
        await file.write(Stream.fromIterable([typedChunk]), offset: offset);
        offset += typedChunk.length;
      }
      print('Done sending file');
    } catch (e) {
      print('Failed to send file to $host:$port, $e');
    } finally {
      return this;
    }
  }

  Future<SSHClient> getClient(host, port, username, password) async {
    final socket = await SSHSocket.connect(host, port);
    return SSHClient(
      socket,
      username: username,
      onPasswordRequest: () => password,
    );
  }
}
