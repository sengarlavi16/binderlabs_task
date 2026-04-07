
import 'package:binder_os_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.08,
            child: GridView.builder(
              itemCount: 400,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 20,
              ),
              itemBuilder: (_, __) =>
                  const Icon(Icons.add, size: 10, color: Colors.white),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
