import 'package:flutter/material.dart';
import 'profilepage.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Center(
              child: Text(
                'USTime',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Your Profile'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => UserProfilePage()), // ✅ Direct push
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Progress Report'),
            onTap: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed('/about');
            },
          ),
        ],
      ),
    );
  }
}
