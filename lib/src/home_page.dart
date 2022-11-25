import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'files_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File("${appStorage.path}/${file.name}");

    return File(file.path!).copy(newFile.path);
  }

  @override
  Widget build(BuildContext context) {
    void openFile(PlatformFile file) {
      OpenFile.open(file.path);
    }

    void openFiles(List<PlatformFile> files) =>
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FilesPage(
                  files: files,
                  onOpenedFile: openFile,
                )));

    return Scaffold(
      appBar: AppBar(
        title: Text("PDF reader"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(allowMultiple: true,type: FileType.custom,allowedExtensions: ["pdf"]);
            if (result == null) return;

            final file = result.files.first;
            openFiles(result.files);
            print("Name: ${file.name}");
            print("Size: ${file.size}");
            print("Bytes: ${file.bytes}");
            print("Extension: ${file.extension}");

            final newFile = await saveFilePermanently(file);
          },
          child: Text("Choose file"),
        ),
      ),
    );
  }
}
