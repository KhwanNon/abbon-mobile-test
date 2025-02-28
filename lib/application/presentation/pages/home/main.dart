import 'dart:io';
import 'package:abbon_mobile_test/application/presentation/pages/home/components/dialog_Image_source.dart';
import 'package:abbon_mobile_test/application/presentation/shared/extension/fade_dialog.dart';
import 'package:abbon_mobile_test/application/presentation/shared/extension/open_map_curr_location.dart';
import 'package:abbon_mobile_test/application/presentation/shared/theme/color.dart';
import 'package:abbon_mobile_test/application/presentation/widget/layouts/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // Show Image Source Dialog
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => FadeTransitionDialog(
            child: ImageSourceDialog(
              onPressed: (source) {
                _pickImage(source);
              },
            ),
          ),
    );
  }

  // Pick Image from the selected source (Camera/Gallery)
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Menu List Data
  final List<Map<String, dynamic>> menu = [
    {
      "name": "Location",
      "text": "home.location".tr(),
      "icon": CupertinoIcons.location,
      "color": Colors.blue,
    },
    {
      "name": "Call",
      "text": "home.call".tr(),
      "icon": CupertinoIcons.phone,
      "color": Colors.blueGrey,
    },
    {
      "name": "Mail",
      "text": "home.mail".tr(),
      "icon": CupertinoIcons.mail,
      "color": Colors.redAccent,
    },
    {
      "name": "Line",
      "text": "home.line".tr(),
      "icon": CupertinoIcons.chat_bubble,
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldApp(
      title: "",
      appBar: false,
      body: Column(children: [_buildHeader(context), const SizedBox(height: 40), _buildMenuGrid()]),
    );
  }

  // Header Section (Avatar & Name)
  Widget _buildHeader(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade100,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                ),
                GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.camera_alt, size: 20, color: Colors.grey.shade300),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Alex Johnson',
              style: Theme.of(context).textTheme.titleLarge?.apply(color: ColorThemeApp.primary),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // Menu Grid Section
  Widget _buildMenuGrid() {
    return Expanded(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return _buildMenuItem(menu[index], context);
        },
      ),
    );
  }

  // Single Menu Item Widget
  Widget _buildMenuItem(Map<String, dynamic> menuItem, BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            await _handleMenuAction(menuItem["name"]);
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: menuItem["color"],
            elevation: 0,
            minimumSize: const Size(70, 70),
          ),
          child: Icon(menuItem["icon"] as IconData, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 10),
        Text(
          menuItem["text"].toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  // Handle Menu Actions (Location, Call, Mail, Line)
  Future<void> _handleMenuAction(String menuName) async {
    switch (menuName) {
      case 'Location':
        await openMapWithCurrentLocation();
        break;
      case 'Call':
        await _launchCall('0800000000');
        break;
      case 'Mail':
        await _launchMail('example@email.com');
        break;
      case 'Line':
        await _launchLine('lineId');
        break;
    }
  }

  // Launch Call
  Future<void> _launchCall(String phoneNumber) async {
    final Uri phoneUri = Uri.parse('tel:$phoneNumber');
    await launchUrl(phoneUri);
  }

  // Launch Mail
  Future<void> _launchMail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    await launchUrl(emailUri);
  }

  // Launch Line
  Future<void> _launchLine(String lineUsername) async {
    final Uri lineUri = Uri.parse('line://ti/p/~$lineUsername');
    await launchUrl(lineUri);
  }
}
