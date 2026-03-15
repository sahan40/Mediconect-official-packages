import 'package:flutter/material.dart';
import 'signup_state.dart';

/// Provider that rebuilds dependents whenever SignupState.notifyListeners() fires.
class SignupProvider extends InheritedNotifier<SignupState> {
  const SignupProvider({
    super.key,
    required SignupState notifier,
    required super.child,
  }) : super(notifier: notifier);

  static SignupState of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<SignupProvider>();
    assert(provider != null, 'No SignupProvider found in widget tree.');
    return provider!.notifier!;
  }
}

class SignupStateManager extends StatefulWidget {
  final Widget child;
  const SignupStateManager({super.key, required this.child});

  @override
  State<SignupStateManager> createState() => _SignupStateManagerState();
}

class _SignupStateManagerState extends State<SignupStateManager> {
  late final SignupState _state;

  @override
  void initState() {
    super.initState();
    _state = SignupState();
  }

  @override
  void dispose() {
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignupProvider(
      notifier: _state,
      child: widget.child,
    );
  }
}