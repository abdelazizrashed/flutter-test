import 'package:evaluation_project/logic/bloc/auth/auth_bloc.dart';
import 'package:evaluation_project/ui/screens/home/home_screen.dart';
import 'package:evaluation_project/ui/screens/register/register_screen.dart';
import 'package:evaluation_project/ui/widgets/custom_button.dart';
import 'package:evaluation_project/ui/widgets/styled_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = "/login";
  static void navigate(BuildContext context) =>
      Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
      );

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoaded) {
              Fluttertoast.showToast(msg: state.model.message);
              HomeScreen.navigate(context);
            }
            if (state is AuthError) {
              Fluttertoast.showToast(msg: state.message);
            }
            if (state is AuthNetworkConnectionError) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInputForm(),
                  Row(
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          RegisterScreen.navigate(context);
                        },
                        child: const Text("Register an account"),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        HomeScreen.navigate(context);
                      },
                      child: const Text("Enter as a guest"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    title: "Login",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        AuthBloc.of(context).add(
                          LoginEvent(
                            phoneController.text,
                            passController.text,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Form _buildInputForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          StyledTextFormField(
            phoneController: phoneController,
            label: "Email",
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "Email is required";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          StyledTextFormField(
            phoneController: passController,
            label: "Password",
            isPassword: true,
            validator: (value) {
              if ((value?.length ?? 0) < 6) {
                return "Password must be longer that 6 characters";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
