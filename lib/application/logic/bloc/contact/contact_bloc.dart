import 'package:abbon_mobile_test/application/presentation/shared/extension/fade_dialog.dart';
import 'package:abbon_mobile_test/application/presentation/shared/navigator_helper.dart';
import 'package:abbon_mobile_test/application/presentation/widget/components/alert_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState.initial()) {
    on<OnRandomContact>(_onRandomContact);
    on<OnNextPage>(_onNextPage);
    on<OnPrevPage>(_onPrevPage);
    on<OnDeleteContact>(_onDeleteContact);
    on<OnSearch>(_onSearch);
    on<OnAddContact>(_onAddContact);
  }

  Future<void> _onRandomContact(OnRandomContact event, Emitter<ContactState> emit) async {
    final faker = Faker();
    final List<Person> contacts = List.generate(100, (_) {
      final fname = faker.person.firstName();
      final lname = faker.person.lastName();
      final age = faker.randomGenerator.integer(80, min: 18);
      return Person(fname: fname, lname: lname, age: age);
    });
    emit(state.copyWith(contactList: contacts));
  }

  void _onNextPage(OnNextPage event, Emitter<ContactState> emit) {
    emit(state.copyWith(page: state.page + 1));
  }

  void _onPrevPage(OnPrevPage event, Emitter<ContactState> emit) {
    emit(state.copyWith(page: state.page - 1));
  }

  Future<void> _onDeleteContact(OnDeleteContact event, Emitter<ContactState> emit) async {
    if (_isValidIndex(event.index)) {
      final updatedList = List<Person>.from(state.contactList!);
      updatedList.removeAt(event.index);
      emit(state.copyWith(contactList: updatedList));
    }
  }

  void _onSearch(OnSearch event, Emitter<ContactState> emit) {
    final searchText = event.text.trim();
    if (searchText.length >= 3) {
      emit(state.copyWith(textSearxh: searchText));
    } else {
      emit(state.copyWith(clearTextSearch: true));
    }
  }

  Future<void> _onAddContact(OnAddContact event, Emitter<ContactState> emit) async {
    if ((state.contactList?.length ?? 0) == 100) {
      _showContactLimitReachedDialog();
    } else {
      await _showContactAddedDialog();
      final updatedList = [event.person, ...(state.contactList ?? <Person>[])];
      emit(state.copyWith(contactList: updatedList));
      Navigator.pop(NavigatorHelper.currContext!);
    }
  }

  bool _isValidIndex(int index) {
    return state.contactList != null && index >= 0 && index < state.contactList!.length;
  }

  void _showContactLimitReachedDialog() {
    _showDialog(AlertType.fail, 'contact.contact_dialog.contact_limit_reached'.tr());
  }

  Future<void> _showContactAddedDialog() async {
    await _showDialog(AlertType.success, 'contact.contact_dialog.contact_added_successfully'.tr());
  }

  Future<void> _showDialog(AlertType type, String message) async {
    await showDialog(
      context: NavigatorHelper.currContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FadeTransitionDialog(child: AlertDialogComponent(type: type, message: message));
      },
    );
  }
}
