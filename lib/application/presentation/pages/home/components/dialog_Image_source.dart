// ignore_for_file: file_names

import 'package:abbon_mobile_test/application/presentation/shared/theme/color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceDialog extends StatelessWidget {
  final Function(ImageSource) onPressed;

  const ImageSourceDialog({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.white,
      title: Text(
        'home.dialog.select_image'.tr(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onPressed(ImageSource.gallery);
          },
          child: Text(
            'home.dialog.gallery'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.apply(color: ColorThemeApp.primary),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onPressed(ImageSource.camera);
          },
          child: Text(
            'home.dialog.camera'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.apply(color: ColorThemeApp.primary),
          ),
        ),
      ],
    );
  }
}
