part of 'name_list_bloc.dart';

abstract class NameListState extends Equatable {
  const NameListState();
}

class NameListInitial extends NameListState {
  @override
  List<Object> get props => [];
}

class NameListLoading extends NameListState {
  @override
  List<Object> get props => [];
}

class NameListLoaded extends NameListState {
  final List<NameModel> nameList;

  const NameListLoaded({
    required this.nameList,
  });

  @override
  List<Object> get props => [nameList];
}
