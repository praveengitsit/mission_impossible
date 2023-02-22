import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/widgets/name_list_dropdown.dart';

import '../blocs/mission_impossible_bloc.dart';
import '../blocs/name_list_bloc.dart';
import '../repositories/mission_impossible_repository.dart';
import '../repositories/name_repository.dart';
import '../widgets/choose_first_letter_dropdown.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => NameRepository(),
        ),
        RepositoryProvider(
          create: (context) => MissionImpossibleRepository(),
        ),
      ],
      child: BlocProvider(
        create: (context) => MissionImpossibleBloc(
          RepositoryProvider.of<MissionImpossibleRepository>(context),
        ),
        child: BlocListener<MissionImpossibleBloc, MissionImpossibleState>(
          listener: (context, state) {
            if (state.status == MissionImpossibleFormStatus.loadingFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No history found!'),
                ),
              );
            }

            if (state.status == MissionImpossibleFormStatus.submissionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Mission started and history saved!'),
                ),
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Mission Impossible"),
            ),
            body: Form(
              key: formKey,
              child: ListView(
                children: [
                  const _Header(),

                  /// The field below is an optional field, but this can have a say
                  /// in how the fields for names of first, second, and third phase
                  /// start from.
                  /// But I cannot seem to find a way to call events for the name blocs
                  /// of the respective field.
                  /// This is a general example of how one field can depend
                  /// on another field for its values.
                  const _FirstLetterForNamesDropdown(),
                  const _NameForFirstPhase(),
                  const _NameForSecondPhase(),
                  const _NameForThirdPhase(),
                  _SubmitButton(
                    formKey: formKey,
                  ),
                  const _LoadHistoryButton(),
                  const Divider(),
                  const _MissionDetails(),
                  const _ResetButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome to Mission Impossible. You have three phases of a mission to complete. Please pick a name for your phases.',
      ),
    );
  }
}

class _FirstLetterForNamesDropdown extends StatelessWidget {
  const _FirstLetterForNamesDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissionImpossibleBloc, MissionImpossibleState>(
      buildWhen: (previous, current) =>
          previous.firstLetterForNames != current.firstLetterForNames,
      builder: (context, state) {
        return Card(
          color: Colors.white60,
          child: Column(
            children: [
              const Text(
                "If you want, you can also pick what you want your names to start with",
              ),
              FirstLetterDropdown(
                onChanged: (value) {
                  context.read<MissionImpossibleBloc>().add(
                        FirstLetterForNamesChanged(
                          firstLetterForNames: value,
                        ),
                      );
                },
                initialValue: state.firstLetterForNames,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NameForFirstPhase extends StatelessWidget {
  const _NameForFirstPhase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameListBloc(
        RepositoryProvider.of<NameRepository>(context),
      )..add(
          const LoadNameListRandom(),
        ),
      child: BlocBuilder<MissionImpossibleBloc, MissionImpossibleState>(
        buildWhen: (previous, current) =>
            previous.nameForFirstPhase != current.nameForFirstPhase,
        builder: (context, state) {
          return NameListDropdown(
            phase: 'Phase 1',
            onChanged: (value) {
              context.read<MissionImpossibleBloc>().add(
                    NameForFirstPhaseChanged(
                      nameForFirstPhase: value,
                    ),
                  );
            },
            initialValue: state.nameForFirstPhase,
          );
        },
      ),
    );
  }
}

class _NameForSecondPhase extends StatelessWidget {
  const _NameForSecondPhase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameListBloc(
        RepositoryProvider.of<NameRepository>(context),
      )..add(
          const LoadNameListRandom(),
        ),
      child: BlocBuilder<MissionImpossibleBloc, MissionImpossibleState>(
        buildWhen: (previous, current) =>
            previous.nameForSecondPhase != current.nameForSecondPhase,
        builder: (context, state) {
          return NameListDropdown(
            phase: 'Phase 2',
            onChanged: (value) {
              context.read<MissionImpossibleBloc>().add(
                    NameForSecondPhaseChanged(
                      nameForSecondPhase: value,
                    ),
                  );
            },
            initialValue: state.nameForSecondPhase,
          );
        },
      ),
    );
  }
}

class _NameForThirdPhase extends StatelessWidget {
  const _NameForThirdPhase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NameListBloc(
        RepositoryProvider.of<NameRepository>(context),
      )..add(
          const LoadNameListRandom(),
        ),
      child: BlocBuilder<MissionImpossibleBloc, MissionImpossibleState>(
        buildWhen: (previous, current) =>
            previous.nameForThirdPhase != current.nameForThirdPhase,
        builder: (context, state) {
          return NameListDropdown(
            phase: 'Phase 3',
            onChanged: (value) {
              context.read<MissionImpossibleBloc>().add(
                    NameForThirdPhaseChanged(
                      nameForThirdPhase: value,
                    ),
                  );
            },
            initialValue: state.nameForThirdPhase,
          );
        },
      ),
    );
  }
}

class _LoadHistoryButton extends StatelessWidget {
  const _LoadHistoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<MissionImpossibleBloc>().add(
                const LoadHistory(),
              );
        },
        child: const Text(
          "Load history",
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _SubmitButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            context.read<MissionImpossibleBloc>().add(
                  const StartMission(),
                );
          }
        },
        child: const Text(
          "Start mission",
        ),
      ),
    );
  }
}

class _MissionDetails extends StatelessWidget {
  const _MissionDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MissionImpossibleBloc, MissionImpossibleState>(
      builder: (context, state) {
        if (state.status == MissionImpossibleFormStatus.submissionSuccess) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Your mission has started.'),
                  Text(
                    'For the next thirty days, your name would be ${state.nameForFirstPhase!.firstName} ${state.nameForFirstPhase!.lastName}. Your secret code would be ${state.nameForFirstPhase!.codeName}',
                  ),
                  const Divider(),
                  Text(
                    'Then you will travel to the Bermuda with the name ${state.nameForSecondPhase!.firstName} ${state.nameForSecondPhase!.lastName}. Your secret code would be ${state.nameForSecondPhase!.codeName}',
                  ),
                  const Divider(),
                  Text(
                    'Lastly, you will arrive at our headquarters with the name ${state.nameForThirdPhase!.firstName} ${state.nameForThirdPhase!.lastName}. Your secret code would be ${state.nameForThirdPhase!.codeName}',
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          context.read<MissionImpossibleBloc>().add(
                const Reset(),
              );
        },
        child: const Text(
          "Reset mission",
        ),
      ),
    );
  }
}
