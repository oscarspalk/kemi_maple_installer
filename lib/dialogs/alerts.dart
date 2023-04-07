import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:macos_ui/macos_ui.dart';

void finish() {
  exit(0);
}

class SuccesfulFinishAlert extends StatelessWidget {
  const SuccesfulFinishAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return const MacosAlertDialog(
        appIcon: Icon(Icons.check),
        title: Text("Installation finished"),
        message:
            Text("The kemi installation is now installed to your computer."),
        primaryButton: PushButton(
          onPressed: finish,
          buttonSize: ButtonSize.large,
          child: Text("Finish"),
        ));
  }
}

class ErrorFinishAlert extends StatelessWidget {
  const ErrorFinishAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return const MacosAlertDialog(
        appIcon: Icon(Icons.error_outline, color: Colors.red),
        title: Text("An error occured"),
        message: Text(
            "The kemi installation failed, try again later or contact us."),
        primaryButton: PushButton(
          onPressed: finish,
          buttonSize: ButtonSize.large,
          child: Text("Close"),
        ));
  }
}
