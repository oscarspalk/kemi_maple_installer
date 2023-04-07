import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kemi_installer/constants.dart';
import 'package:kemi_installer/dialogs/alerts.dart';
import 'package:kemi_installer/downloader.dart';
import 'package:macos_ui/macos_ui.dart';

class FileLocationScreen extends StatefulWidget {
  const FileLocationScreen({super.key});

  @override
  State<FileLocationScreen> createState() => _FileLocationScreenState();
}

class _FileLocationScreenState extends State<FileLocationScreen> {
  String? location;
  bool _processing = false;
  void selectDirectory() async {
    String? directoryPath = await FilePicker.platform
        .getDirectoryPath(dialogTitle: "Choose Maple directory");
    setState(() {
      location = directoryPath;
    });
  }

  void installDependencies() async {
    setState(() => {_processing = true});
    try {
      List<int> elementBytes =
          await Downloader.download(Constants.elementsFileUri);
      await Downloader.saveTo(
          "$location/data/kemi/elements.json", elementBytes);
      List<int> jarBytes = await Downloader.download(Constants.jarFileUri);
      await Downloader.saveTo("$location/data/kemi/kemi.jar", jarBytes);
      List<int> mlaBytes = await Downloader.download(Constants.mlaFileUri);
      await Downloader.saveTo("$location/lib/kemi.mla", mlaBytes);
      showMacosAlertDialog(
        builder: (context) {
          return const SuccesfulFinishAlert();
        },
        context: context,
      );
    } catch (e) {
      debugPrint("err");
      showMacosAlertDialog(
        context: context,
        builder: (context) {
          return const ErrorFinishAlert();
        },
      );
    }
  }

  final TextStyle _titleStyle = const TextStyle(fontSize: 36.0);

  @override
  Widget build(BuildContext context) {
    return _processing
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Maple Kemi Extension Installer", style: _titleStyle),
              Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(location ?? "Please choose your Maple directory.  "),
                      PushButton(
                        buttonSize: ButtonSize.large,
                        onPressed: selectDirectory,
                        child: const Text("Choose"),
                      )
                    ],
                  )),
              PushButton(
                buttonSize: ButtonSize.large,
                onPressed: location != null && location!.contains("maple")
                    ? installDependencies
                    : null,
                child: const Text("Install"),
              )
            ],
          );
  }
}
