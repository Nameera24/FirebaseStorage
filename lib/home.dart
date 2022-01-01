import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/storage_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var results;
  var images;
  Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            onPressed: () async {
              results = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ["pdf", "jpg", "png", "jpeg"],
              );
              setState(() {
                results = results;
              });
              print(results.files.single.path);
              if (results == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("No file chosen"),
                  ),
                );
              }
              final pathname = results.files.single.path;
              final filename = results.files.single.name;
              storage.uploadFile(pathname, filename);
            },
            child: Text("upload file Here")),
        if (results != null)
          Container(
            child: Image.file(File(results.files.single.path)),
          )
      ]),
    );
  }
}
