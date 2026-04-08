import 'package:flutter/material.dart';
import 'login_state.dart';

class LoginProvider extends InheritedWidget {
  final LoginState state;

  const LoginProvider({super.key, required this.state, required super.child});

  static LoginProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<LoginProvider>();
    assert(provider != null, 'No LoginProvider found in widget tree.');
    return provider!;
  }

  @override
  bool updateShouldNotify(LoginProvider oldWidget) => true;
}

class LoginStateManager extends StatefulWidget {
  final Widget child;
  const LoginStateManager({super.key, required this.child});

  @override
  State<LoginStateManager> createState() => _LoginStateManagerState();
}

class _LoginStateManagerState extends State<LoginStateManager> {
  late final LoginState _loginState;

  @override
  void initState() {
    super.initState();
    _loginState = LoginState();
    _loginState.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    _loginState.removeListener(_rebuild);
    _loginState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginProvider(state: _loginState, child: widget.child);
  }
}
