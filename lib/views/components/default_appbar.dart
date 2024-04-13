import 'package:flutter/material.dart';
import 'package:jmoov/core/providers/app.dart';
import 'package:jmoov/core/services/auth_service.dart';
import 'package:jmoov/helpers.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService.instance.of(context);

    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      title: const Image(
        image: AssetImage('assets/images/logo.webp'),
        height: 32,
      ),
      centerTitle: false,
      actions: [
        MenuAnchor(
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
            return _UserAvatar(
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
            );
          },
          menuChildren: [
            MenuItemButton(
              leadingIcon: const Icon(Icons.person),
              child: const Text('Mon profil'),
              onPressed: () => Navigator.pushNamed(context, '/profile'),
            ),
            MenuItemButton(
              leadingIcon: const Icon(Icons.loop_rounded),
              child: const Text('Mes souscriptions'),
              onPressed: () {
                Navigator.pushNamed(context, '/my-subscriptions');
              },
            ),
            const Divider(),
            MenuItemButton(
              leadingIcon: const Icon(Icons.logout),
              child: const Text('Déconnexion'),
              onPressed: () {
                authService.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _UserAvatar extends StatelessWidget {
  final VoidCallback onTap;

  const _UserAvatar({required this.onTap});

  @override
  Widget build(BuildContext context) {
    AppProvider provider = getProvider<AppProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: SizedBox(
        width: 48,
        height: 48,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(256),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(avatarUrl(provider.user!.fullName)),
            ),
          ),
        ),
      ),
    );
  }
}
