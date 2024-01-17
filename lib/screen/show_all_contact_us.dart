import 'package:flutter/material.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
class ContactUsAdmin extends StatefulWidget {
  const ContactUsAdmin({super.key});

  @override
  State<ContactUsAdmin> createState() => _ContactUsAdminState();
}

class _ContactUsAdminState extends State<ContactUsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBar(
        body: ContactUsAdminCall(),
      ),
    );
  }
}
class ContactUsAdminCall extends StatefulWidget {
  const ContactUsAdminCall({super.key});

  @override
  State<ContactUsAdminCall> createState() => _ContactUsAdminCallState();
}

class _ContactUsAdminCallState extends State<ContactUsAdminCall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
