import 'package:bloc/bloc.dart';
import 'package:faker/faker.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState.initial()) {
    on<OnRandomContact>((event, emit) async {
      final faker = Faker(); // Create an instance of Faker
      List<Person> contacts = [];

      for (int i = 0; i < 100; i++) {
        String fname = faker.person.firstName();
        String lname = faker.person.lastName();
        int age = faker.randomGenerator.integer(
          80,
          min: 18,
        ); // Random age between 18 and 80
        contacts.add(Person(fname: fname, lname: lname, age: age));
      }

      emit(state.copyWith(contactList: contacts));
    });

    on<OnNextPage>((event, emit) async {
      emit(state.copyWith(page: state.page + 1));
    });

    on<OnPrevPage>((event, emit) async {
      emit(state.copyWith(page: state.page - 1));
    });

    on<OnDeleteContact>((event, emit) async {
      if (state.contactList != null &&
          event.index >= 0 &&
          event.index < state.contactList!.length) {
        // copy data
        final updatedList = List<Person>.from(state.contactList!);

        updatedList.removeAt(event.index);

        emit(state.copyWith(contactList: updatedList));
      }
    });

    on<OnSearch>((event, emit) async {
      final searchText = event.text.trim();
      if (searchText.length >= 3) {
        emit(state.copyWith(textSearxh: searchText));
      } else {
        emit(state.copyWith(clearTextSearch: true));
      }
    });
  }
}
