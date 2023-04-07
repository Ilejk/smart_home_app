import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_app/features/auth/providers/login_provider.dart';
import 'package:smart_home_app/features/auth/providers/register_provider.dart';
import 'package:smart_home_app/utils/managers/asset_manager.dart';
import 'package:smart_home_app/utils/managers/color_manager.dart';
import 'package:smart_home_app/utils/managers/string_manager.dart';
import 'package:smart_home_app/utils/managers/style_manager.dart';
import 'package:smart_home_app/utils/managers/value_manager.dart';
import 'package:smart_home_app/utils/router/router.dart';
import 'package:smart_home_app/utils/widgets/green_gradient_button_widget.dart';
import 'package:smart_home_app/features/auth/widgets/text_form_field_auth.dart';

enum AuthMode { signUp, signIn }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  AuthMode _authMode = AuthMode.signIn;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final registerProvider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      backgroundColor: ColorManager.darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: PaddingManager.p12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: PaddingManager.p8),
                  child: SizedBox(
                    width: SizeManager.s250,
                    height: SizeManager.s250,
                    child: Image.asset(
                      ImageManager.logoTextUnder,
                    ),
                  ),
                ),
                TextFormFieldWidget(
                  width: SizeManager.s400,
                  controller: emailController,
                  labelHint: StringsManager.emailHint,
                  obscureText: false,
                ),
                TextFormFieldWidget(
                  width: SizeManager.s400,
                  controller: passwordController,
                  labelHint: StringsManager.passwordHint,
                  obscureText: true,
                ),
                _authMode == AuthMode.signUp
                    ? TextFormFieldWidget(
                        width: SizeManager.s400,
                        controller: repeatPasswordController,
                        labelHint: StringsManager.repeatPasswordHint,
                        obscureText: true,
                      )
                    : Container(),
                _authMode == AuthMode.signIn
                    ? Padding(
                        padding: const EdgeInsets.only(
                            right: PaddingManager.p28,
                            left: PaddingManager.p28),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.forgotPasswordRoute);
                            },
                            child: const Text(
                              StringsManager.forgotPassword,
                              style: StyleManager.loginPageSubTextTextStyle,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(top: PaddingManager.p2),
                  child: LimeGreenRoundedButtonWidget(
                    onTap: _authMode == AuthMode.signUp &&
                            passwordController.text ==
                                repeatPasswordController.text
                        ? () {
                            registerProvider.register(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context);
                          }
                        : () {
                            loginProvider.signIn(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            );
                          },
                    title: _authMode == AuthMode.signIn
                        ? StringsManager.signIn
                        : StringsManager.signUp,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: PaddingManager.p28,
                    right: PaddingManager.p28,
                    top: PaddingManager.p18,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _authMode == AuthMode.signIn
                            ? StringsManager.dontHaveAcc
                            : StringsManager.haveAcc,
                        style: StyleManager.loginPageSubTextTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: PaddingManager.p8),
                        child: GestureDetector(
                          onTap: _switchAuthMode,
                          child: Text(
                            _authMode == AuthMode.signIn
                                ? StringsManager.signUp
                                : StringsManager.signIn,
                            style:
                                StyleManager.loginPageSubButtonSmallTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 500.ms),
          ),
        ),
      ),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.signIn) {
      setState(() {
        _authMode = AuthMode.signUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.signIn;
      });
    }
  }
}
