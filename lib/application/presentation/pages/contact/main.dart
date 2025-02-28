// ignore_for_file: use_build_context_synchronously

import 'package:abbon_mobile_test/application/logic/bloc/contact/contact_bloc.dart';
import 'package:abbon_mobile_test/application/presentation/pages/contact/components/dialog_form.dart';
import 'package:abbon_mobile_test/application/presentation/shared/extension/fade_dialog.dart';
import 'package:abbon_mobile_test/application/presentation/shared/theme/color.dart';
import 'package:abbon_mobile_test/application/presentation/widget/layouts/scaffold.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const FadeTransitionDialog(child: ContactDialogFormComponent());
      },
    ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScaffoldApp(
        title: 'contact.contact_list_title'.tr(),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _buildMainContent(context),
            _buildAddButton(context),
            _buildPaginationInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        _buildSearchField(context),
        _buildContactList(context),
        _buildPaginationControls(context),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _searchController,
        autofocus: false,
        decoration: InputDecoration(
          labelText: 'contact.search_by_name'.tr(),
          suffixIcon: IconButton(
            onPressed: () {
              if (_searchController.text.isEmpty) return;
              _searchController.clear();
              context.read<ContactBloc>().add(OnSearch(text: ''));
            },
            icon: const Icon(Icons.clear),
          ),
          border: _textFieldBorder(),
          enabledBorder: _textFieldBorder(),
          focusedBorder: _textFieldBorder(color: ColorThemeApp.primary),
        ),
        onChanged: (text) => context.read<ContactBloc>().add(OnSearch(text: text)),
      ),
    );
  }

  OutlineInputBorder _textFieldBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildContactList(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) => _buildListView(context, state),
      ),
    );
  }

  Widget _buildListView(BuildContext context, ContactState state) {
    final contactList = state.contactList;
    final searchText = state.textSearxh?.toLowerCase();
    const int itemsPerPage = 20;
    final int page = state.page;

    if (contactList == null || contactList.isEmpty) {
      return Center(
        child: Text(
          'contact.no_contacts_available'.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    final filteredList =
        searchText == null || searchText.isEmpty
            ? contactList
            : contactList
                .where(
                  (person) => "${person.fname} ${person.lname}".toLowerCase().contains(searchText),
                )
                .toList();

    final int filteredContactNum = filteredList.length;
    final int startIndex = page * itemsPerPage;
    final int endIndex =
        (startIndex + itemsPerPage) > filteredContactNum
            ? filteredContactNum
            : (startIndex + itemsPerPage);

    if (filteredContactNum == 0 || startIndex >= filteredContactNum) {
      return Center(
        child: Text(
          'contact.no_matching_contacts_found'.tr(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: endIndex - startIndex,
      itemBuilder: (context, index) {
        final actualIndex = startIndex + index;
        final person = filteredList[actualIndex];
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 15),
          title: Text(
            "${person.fname} ${person.lname}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(
            '${'contact.age'.tr()}: ${person.age}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: IconButton(
            icon: const Icon(CupertinoIcons.delete, size: 18),
            onPressed: () {
              final originalIndex = contactList.indexOf(person);
              context.read<ContactBloc>().add(OnDeleteContact(index: originalIndex));
            },
          ),
        );
      },
    );
  }

  Widget _buildPaginationControls(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ContactBloc, ContactState>(
          builder: (context, state) {
            final int contactNum = state.contactList?.length ?? 0;
            final int page = state.page;
            const int itemsPerPage = 20;
            final int startIndex = page * itemsPerPage;
            final int endIndex =
                (startIndex + itemsPerPage) > contactNum ? contactNum : (startIndex + itemsPerPage);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed:
                        state.page == 0
                            ? null
                            : () => context.read<ContactBloc>().add(OnPrevPage()),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed:
                        (contactNum == 0 || endIndex >= contactNum)
                            ? null
                            : () => context.read<ContactBloc>().add(OnNextPage()),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 90),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Positioned(
      bottom: 105,
      child: ClipOval(
        child: Material(
          color: ColorThemeApp.primary,
          child: InkWell(
            onTap: () => _showContactDialog(context),
            child: const SizedBox(
              width: 70,
              height: 70,
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationInfo(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        final int contactNum = state.contactList?.length ?? 0;
        final int page = state.page;
        const int itemsPerPage = 20;
        final int startIndex = page * itemsPerPage;
        final int endIndex =
            (startIndex + itemsPerPage) > contactNum ? contactNum : (startIndex + itemsPerPage);

        final int displayStart = contactNum == 0 ? 0 : startIndex + 1;
        final int displayEnd = endIndex;
        return Positioned(
          bottom: 85,
          child: Text(
            "$displayStart-$displayEnd ${'contact.of'.tr()} $contactNum",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      },
    );
  }
}
