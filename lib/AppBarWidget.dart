import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String subtitle;
  final VoidCallback? onExit;

  const AppBarWidget({
    Key? key,
    required this.backgroundColor,
    required this.subtitle,
    this.onExit,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'FANG',
              style: TextStyle(
                fontFamily: fontFamily,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Text(
              subtitle,
              style: TextStyle(
                fontFamily: fontFamily,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: customColor,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/img/logo_potter_blanc.png'),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: onExit,
        ),
      ],
    );
  }
}
