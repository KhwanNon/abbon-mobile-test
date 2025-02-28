import 'package:abbon_mobile_test/application/logic/bloc/contact/contact_bloc.dart';
import 'package:abbon_mobile_test/application/presentation/shared/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactDialogFormComponent extends StatefulWidget {
  const ContactDialogFormComponent({super.key});

  @override
  State<ContactDialogFormComponent> createState() => _ContactDialogFormComponentState();
}

class _ContactDialogFormComponentState extends State<ContactDialogFormComponent> {
  final _formKey = GlobalKey<FormState>();
  String? fname;
  String? lname;
  String? age;

  void _saveContact(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ContactBloc>().add(
        OnAddContact(
          person: Person(fname: fname ?? "", lname: lname ?? "", age: int.parse(age ?? "0")),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade100,
      title: _buildTitle(context),
      content: _buildContent(context),
      actions: _buildActions(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'contact.contact_dialog.create_contact'.tr(),
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(
                hintText: 'contact.contact_dialog.first_name'.tr(),
                validator: _validateName('first'),
                onChanged: (value) => fname = value,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                hintText: 'contact.contact_dialog.last_name'.tr(),
                validator: _validateName('last'),
                onChanged: (value) => lname = value,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                hintText: 'contact.contact_dialog.age'.tr(),
                keyboardType: TextInputType.number,
                validator: _validateAge,
                onChanged: (value) => age = value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'contact.contact_dialog.cancel'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.apply(color: Colors.grey.shade500),
        ),
      ),
      TextButton(
        onPressed: () => _saveContact(context),
        child: Text(
          'contact.contact_dialog.save'.tr(),
          style: Theme.of(context).textTheme.titleMedium?.apply(color: ColorThemeApp.primary),
        ),
      ),
    ];
  }

  Widget _buildTextField({
    required String hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      cursorColor: ColorThemeApp.primary,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall?.apply(color: Colors.grey.shade500),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorThemeApp.primary),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }

  String? Function(String?) _validateName(String field) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'contact.contact_dialog.please_enter_${field}_name'.tr();
      }

      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
        return 'contact.contact_dialog.only_letters_allowed'.tr();
      }

      return null;
    };
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) return 'contact.contact_dialog.please_enter_age'.tr();
    if (int.tryParse(value) == null) return 'contact.contact_dialog.please_enter_valid_number'.tr();
    return null;
  }
}
