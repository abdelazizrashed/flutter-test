// import 'package:evaluation_project/domain/models/local/shared_prefs.dart';
import 'package:evaluation_project/domain/local/shared_prefs.dart';
import 'package:evaluation_project/ui/screens/home/home_screen.dart';
import 'package:evaluation_project/ui/widgets/drawer_button.dart';
import 'package:flutter/material.dart';

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
          _buildProfileInfor(context),
          Padding(
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
                if (getUserToken() == null && getUserToken()!.isEmpty)
                  DrawerButton(
                    name: "Login",
                    icon: Icons.login,
                    onTap: () {
                      Navigator.of(context).pop();
                      //TODO: Implement this
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (getUserToken() != null && getUserToken()!.isNotEmpty)
                  DrawerButton(
                    name: "Logout",
                    icon: Icons.logout,
                    onTap: () {
                      Navigator.of(context).pop();
                      //TODO: Implement this
                    },
                  ),
              ],
            ),
          )
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
