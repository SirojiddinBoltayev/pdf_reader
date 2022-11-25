import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../pinch.dart';

class FilesPage extends StatefulWidget {
  final List<PlatformFile> files;

  FilesPage({Key? key, required this.files, })
      : super(key: key);

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Files"),
      ),
      body: Center(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
            itemCount: widget.files.length,
            itemBuilder: (context, index) {
              final file = widget.files[index];
              return buildFile(file);
            }),
      ),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)}";
    final extension = file.extension ?? "none";
    final color = Colors.redAccent;

    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PinchPage( files: file,))),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  ".$extension",
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8,),
            Text(file.name,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,),
            Text(fileSize,style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
