part of 'name_list_bloc.dart';

abstract class NameListEvent extends Equatable {
  const NameListEvent();
}

class LoadNameListRandom extends NameListEvent {
  const LoadNameListRandom();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadNameListStartingFrom extends NameListEvent {
  final String firstLetter;

  const LoadNameListStartingFrom({
    required this.firstLetter,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        firstLetter,
      ];
}
