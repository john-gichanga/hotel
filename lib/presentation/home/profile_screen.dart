import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotel/presentation/home/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:hotel/providers/auth_provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:hotel/domain/models/user_model.dart';

import '../../data/dummy_user.dart';
import '../../domain/services/admin_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final UserModel? user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          text: 'Hi,  ',
                          style: const TextStyle(
                            color: Colors.cyan,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: user!.displayName,
                              style: const TextStyle(
                                color: Colors.cyan,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('My name is pressed');
                                },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextWidget(
                        text: user.email,
                        color: Colors.cyan,
                        textSize: 18,
                      ),
                      const Divider(thickness: 2),
                      const SizedBox(height: 20),
                      _listTiles(
                        title: 'Address 2',
                        subtitle: 'My subtitle',
                        icon: IconlyLight.profile,
                        onPressed: () {
                          AdminService().setAdmin(dummyUser);
                        },
                        color: Colors.cyan,
                      ),
                      _listTiles(
                        title: 'Bookings',
                        icon: IconlyLight.bag,
                        onPressed: () {},
                        color: Colors.cyan,
                      ),
                      _listTiles(
                        title: 'Viewed',
                        icon: IconlyLight.show,
                        onPressed: () {},
                        color: Colors.cyan,
                      ),
                      _listTiles(
                        title: 'Change Password',
                        icon: IconlyLight.unlock,
                        onPressed: () {},
                        color: Colors.cyan,
                      ),
                      _listTiles(
                        title: 'Logout',
                        icon: IconlyLight.logout,
                        onPressed: () {
                          authProvider.signOut(context);
                        },
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
      ),
      subtitle: subtitle != null
          ? TextWidget(
              text: subtitle,
              color: color,
              textSize: 18,
            )
          : null,
      leading: Icon(icon, color: color),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
