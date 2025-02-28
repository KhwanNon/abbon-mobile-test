part of 'contact_bloc.dart';

abstract class ContactEvent {}

class OnAddContact extends ContactEvent {
  final Person person;
  OnAddContact({required this.person});
}

class OnDeleteContact extends ContactEvent {
  final int index;
  OnDeleteContact({required this.index});
}

class OnSearch extends ContactEvent {
  final String text;
  OnSearch({required this.text});
}

class OnNextPage extends ContactEvent {}

class OnPrevPage extends ContactEvent {}

class OnRandomContact extends ContactEvent {}
