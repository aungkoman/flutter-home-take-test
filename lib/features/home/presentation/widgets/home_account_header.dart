import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/domain/entities/user_entity.dart';

class HomeAccountHeader extends StatelessWidget {
  const HomeAccountHeader({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    final String name = user == null
        ? "Welcome to J' Donuts"
        : '${user!.firstName} ${user!.lastName}'.trim();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF6D6E7),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/home-01-j-donuts-new-logo-1.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isEmpty ? 'Hello, donut lover' : name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF24292D),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.phone ?? 'A little moment of joy',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF47555B),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'View catalog',
                  onPressed: () => context.push('/home/catalog'),
                  icon: const Icon(Icons.grid_view_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: user == null ? () => context.go('/login') : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.workspace_premium_outlined,
                        color: Color(0xFFD45D98),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          user == null
                              ? 'Sign in for membership rewards'
                              : '${user!.currentPoints} points · ${user!.member.name} member',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
