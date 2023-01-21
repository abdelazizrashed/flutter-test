// import 'package:evaluation_project/domain/models/local/shared_prefs.dart';
// import 'package:evaluation_project/domain/local/shared_prefs.dart';
import 'package:evaluation_project/logic/bloc/auth/auth_bloc.dart';
import 'package:evaluation_project/logic/repositories/auth/auth_repository.dart';
import 'package:evaluation_project/ui/screens/home/home_screen.dart';
import 'package:evaluation_project/ui/screens/login/login_screen.dart';
import 'package:evaluation_project/ui/widgets/drawer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: [
          if (!AuthRepository.get().isLoggedIn())
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
          if (AuthRepository.get().isLoggedIn()) _buildProfileInfor(context),
          _buildButtons(context)
        ],
      ),
    );
  }

  Padding _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        children: [
          DrawerButton(
            name: "Home",
            icon: Icons.home,
            onTap: () => HomeScreen.navigate(context),
          ),
          const SizedBox(
            height: 10,
          ),
          if (!AuthRepository.get().isLoggedIn())
            DrawerButton(
              name: "Login",
              icon: Icons.login,
              onTap: () {
                Navigator.of(context).pop();
                LoginScreen.navigate(context);
              },
            ),
          const SizedBox(
            height: 10,
          ),
          if (AuthRepository.get().isLoggedIn())
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  LoginScreen.navigate(context);
                }
              },
              child: DrawerButton(
                name: "Logout",
                icon: Icons.logout,
                onTap: () {
                  Navigator.of(context).pop();
                  AuthBloc.of(context).add(LogoutEvent());
                },
              ),
            ),
        ],
      ),
    );
  }

  Container _buildProfileInfor(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.teal[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(2000),
            child: Image.network(
              "",
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 70,
                  height: 70,
                  color: Colors.blue,
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Mohamed",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "test@test.com",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
