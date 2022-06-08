import 'package:flutter/material.dart';
import 'package:maxfit/domain/AuthUser.dart';
import 'package:maxfit/pages/auth_page.dart';
import 'package:maxfit/pages/home_page.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthUser? authUser = Provider.of(context);
    final bool isLoggedIn = authUser != null;

    return isLoggedIn ? HomePage() : AuthorizationPage();
  }
}
