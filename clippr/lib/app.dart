import 'package:clippr/screens/profile/local-widget/informations_personnelles/Informations_personnelles.dart';
import 'package:clippr/screens/profile/local-widget/invite/invite.dart';
import 'package:clippr/screens/profile/local-widget/login_methods.dart';
import 'package:clippr/screens/profile/local-widget/one_time_password.dart';
import 'package:clippr/screens/main_navigation_screen.dart';
import 'package:clippr/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'screens/provider/provider.dart';
import 'style.dart';

const HomeRoute = '/';
const ProviderRoute = '/provider';
const ProfileRoute = '/profile';
const LoginMethodsRoute = '/login-methods';
const OneTimePasswordRoute = '/one-time-password';
const InviteRoute = '/invite';
const InformationsPersonnellesRoute = '/informations-personnelles';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
      theme: _theme(),
    );
  }
}

ThemeData _theme() {
  return ThemeData(
      textTheme: TextTheme(
    headline5: Headline5TextStyle,
    headline6: Headline6TextStyle,
    bodyText1: BodyText1TextStyle,
    bodyText2: BodyText2TextStyle,
  ));
}

RouteFactory _routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;
    switch (settings.name) {
      case HomeRoute:
        screen = MainNavigationScreen();
        break;
      case ProviderRoute:
        screen = Provider(arguments['id']);
        break;
      case ProfileRoute:
        screen = Profile();
        break;
      case LoginMethodsRoute:
        screen = LoginMethods();
        break;
      case InviteRoute:
        screen = Invite();
        break;
      case InformationsPersonnellesRoute:
        screen = InformationsPersonnelles();
        break;
      case OneTimePasswordRoute:
        screen = OneTimePassword(
            arguments['phoneNumber'],
            arguments['phoneAuthCredential'],
            arguments['verificationId'],
            arguments['code']);
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
