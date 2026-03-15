import 'package:flutter/material.dart';
import 'medical_history_state.dart';


class MedicalHistoryProvider extends InheritedNotifier<MedicalHistoryState> {
  const MedicalHistoryProvider({
    super.key,
    required MedicalHistoryState notifier,
    required super.child,
  }) : super(notifier: notifier);

  static MedicalHistoryState of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<MedicalHistoryProvider>();
    assert(provider != null, 'No MedicalHistoryProvider found in widget tree.');
    return provider!.notifier!;
  }
}

class MedicalHistoryStateManager extends StatefulWidget {
  final Widget child;
  const MedicalHistoryStateManager({super.key, required this.child});

  @override
  State<MedicalHistoryStateManager> createState() =>
      _MedicalHistoryStateManagerState();
}

class _MedicalHistoryStateManagerState extends State<MedicalHistoryStateManager> {
  late final MedicalHistoryState _state;

  @override
  void initState() {
    super.initState();
    _state = MedicalHistoryState();
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MedicalHistoryProvider(
      notifier: _state,
      child: widget.child,
    );
  }
}