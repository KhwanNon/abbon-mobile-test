import 'package:abbon_mobile_test/application/logic/bloc/contact/contact_bloc.dart';
import 'package:abbon_mobile_test/application/presentation/widget/layouts/scaffold.dart';
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ScaffoldApp(
        title: "Contact",
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search by Name',
                            suffixIcon: IconButton(
                              onPressed: () {
                                _searchController.clear();
                                context.read<ContactBloc>().add(
                                  OnSearch(text: ''),
                                );
                              },
                              icon: Icon(Icons.clear),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          onChanged: (text) {
                            context.read<ContactBloc>().add(
                              OnSearch(text: text),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<ContactBloc, ContactState>(
                    builder: (context, state) {
                      final List<Person>? contactList = state.contactList;
                      final String? searchText =
                          state.textSearxh?.toLowerCase();
                      final int page = state.page;
                      const int itemsPerPage = 20;

                      if (contactList == null || contactList.isEmpty) {
                        return Center(child: Text("No contacts available"));
                      }

                      final filteredList =
                          searchText == null || searchText.isEmpty
                              ? contactList
                              : contactList.where((person) {
                                final fullName =
                                    "${person.fname} ${person.lname}"
                                        .toLowerCase();
                                return fullName.contains(searchText);
                              }).toList();

                      final int filteredContactNum = filteredList.length;

                      final int startIndex = page * itemsPerPage;
                      final int endIndex =
                          (startIndex + itemsPerPage) > filteredContactNum
                              ? filteredContactNum
                              : (startIndex + itemsPerPage);

                      if (filteredContactNum == 0 ||
                          startIndex >= filteredContactNum) {
                        return Center(
                          child: Text("No matching contacts found"),
                        );
                      }

                      return ListView.builder(
                        itemCount: endIndex - startIndex,
                        itemBuilder: (context, index) {
                          final int actualIndex = startIndex + index;
                          final fname = filteredList[actualIndex].fname;
                          final lname = filteredList[actualIndex].lname;
                          final age = filteredList[actualIndex].age;

                          return ListTile(
                            contentPadding: EdgeInsets.only(left: 15),
                            title: Text("$fname $lname"),
                            subtitle: Text('Age: $age'),
                            trailing: IconButton(
                              icon: Icon(CupertinoIcons.delete, size: 18),
                              onPressed: () {
                                final originalIndex = contactList.indexOf(
                                  filteredList[actualIndex],
                                );
                                context.read<ContactBloc>().add(
                                  OnDeleteContact(index: originalIndex),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                Column(
                  children: [
                    BlocBuilder<ContactBloc, ContactState>(
                      builder: (context, state) {
                        final int contactNum = state.contactList?.length ?? 0;
                        final int page = state.page;
                        const int itemsPerPage = 20;
                        final int startIndex = page * itemsPerPage;
                        final int endIndex =
                            (startIndex + itemsPerPage) > contactNum
                                ? contactNum
                                : (startIndex + itemsPerPage);

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed:
                                    state.page == 0
                                        ? null
                                        : () {
                                          context.read<ContactBloc>().add(
                                            OnPrevPage(),
                                          );
                                        },
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed:
                                    (contactNum == 0 || endIndex >= contactNum)
                                        ? null
                                        : () {
                                          context.read<ContactBloc>().add(
                                            OnNextPage(),
                                          );
                                        },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 90),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 105,
              child: ClipOval(
                child: Material(
                  color: Colors.blueAccent,
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<ContactBloc, ContactState>(
              builder: (context, state) {
                final int contactNum = state.contactList?.length ?? 0;
                final int page = state.page;
                const int itemsPerPage = 20;
                final int startIndex = page * itemsPerPage;
                final int endIndex =
                    (startIndex + itemsPerPage) > contactNum
                        ? contactNum
                        : (startIndex + itemsPerPage);

                final int displayStart = contactNum == 0 ? 0 : startIndex + 1;
                final int displayEnd = endIndex;
                return Positioned(
                  bottom: 85,
                  child: Text(
                    "$displayStart-$displayEnd of $contactNum",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
