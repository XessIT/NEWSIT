import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read/screens/signup.dart';

import '../bloc/signup/signup_bloc.dart';
import '../repositories/signup/signup_action.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({super.key});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    final signUpAction = SignupAction();
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => signUpAction)
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => SignupBloc())
          ],
          child: SignUpScreen(),
        )
    );
  }
}
