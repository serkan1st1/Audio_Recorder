import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/i_auth_service.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<IAuthService>(context, listen: false);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              await authService.signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple.shade800.withOpacity(0.8),
            ),
            child: const Text("Log Out"),
          ),
        ],
      ),
    );
  }
}
