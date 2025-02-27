part of 'contact_bloc.dart';

class ContactState {
  final String? textSearxh;
  final int page;
  final List<Person>? contactList;

  ContactState({
    required this.contactList,
    this.textSearxh,
    required this.page,
  });

  static ContactState initial() {
    return ContactState(contactList: null, textSearxh: null, page: 0);
  }

  ContactState copyWith({
    List<Person>? contactList,
    String? textSearxh,
    int? page,
    bool clearTextSearch = false,
  }) {
    return ContactState(
      contactList: contactList ?? this.contactList,
      textSearxh: clearTextSearch ? null : textSearxh ?? this.textSearxh,
      page: page ?? this.page,
    );
  }
}

class Person {
  final String fname;
  final String lname;
  final int age;
  Person({required this.fname, required this.lname, required this.age});
}
