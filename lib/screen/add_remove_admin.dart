import 'package:flutter/material.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class AddRemoveAdmin extends StatefulWidget {
  const AddRemoveAdmin({super.key});

  @override
  State<AddRemoveAdmin> createState() => _AddRemoveAdminState();
}

class _AddRemoveAdminState extends State<AddRemoveAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBar(
        body: AddRemoveAdminCall(),
      ),
    );
  }
}

class AddRemoveAdminCall extends StatefulWidget {
  const AddRemoveAdminCall({super.key});

  @override
  State<AddRemoveAdminCall> createState() => _AddRemoveAdminCallState();
}

class _AddRemoveAdminCallState extends State<AddRemoveAdminCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
