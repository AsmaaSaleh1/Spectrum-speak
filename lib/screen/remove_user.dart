import 'package:flutter/material.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class RemoveUser extends StatefulWidget {
  const RemoveUser({super.key});

  @override
  State<RemoveUser> createState() => _RemoveUserState();
}

class _RemoveUserState extends State<RemoveUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBar(
        body: RemoveUserCall(),
      ),
    );
  }
}

class RemoveUserCall extends StatefulWidget {
  const RemoveUserCall({super.key});

  @override
  State<RemoveUserCall> createState() => _RemoveUserCallState();
}

class _RemoveUserCallState extends State<RemoveUserCall> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
