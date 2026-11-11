import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/tab_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: const Color(0xFFC7E7EF),
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                        backgroundColor: tabPink,
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your account',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text('J’Donuts customer'),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => showTabSheet(
                          context,
                          'Edit Profile',
                          'Your profile details will appear here.',
                        ),
                        child: const Text(
                          'EDIT',
                          style: TextStyle(
                            color: tabPink,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => showTabSheet(
                      context,
                      'Membership',
                      'Explore Silver, Gold and Platinum rewards.',
                    ),
                    label: const Text('E-wallet Customer'),
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _item(
            context,
            Icons.assignment_outlined,
            'My Orders',
            'No orders yet.',
          ),
          _item(
            context,
            Icons.favorite_border,
            'My Favorites',
            'No favorites yet.',
          ),
          _item(
            context,
            Icons.person_outline,
            'Account',
            'Your account details will appear here.',
          ),
          _item(
            context,
            Icons.confirmation_number_outlined,
            'Promotions',
            'No promotions available.',
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 28),
            minVerticalPadding: 12,
            leading: const Icon(Icons.translate, color: Color(0xFF7F8A93)),
            title: const Text(
              'Language',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('ENGLISH', style: TextStyle(fontSize: 12)),
                Icon(Icons.chevron_right),
              ],
            ),
            onTap: () => showTabSheet(context, 'Language', 'English'),
          ),
          _item(context, Icons.info_outline, 'About', 'Welcome to J’Donuts.'),
          _item(
            context,
            Icons.article_outlined,
            'Terms & Conditions',
            'Terms and conditions will appear here.',
          ),
          _item(
            context,
            Icons.fact_check_outlined,
            'Privacy Policy',
            'Privacy policy will appear here.',
          ),
          _item(
            context,
            Icons.logout,
            'Logout',
            'You can manage your sign-in here.',
          ),
          const SizedBox(height: 20),
          const Text(
            'J’Donuts',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 140),
        ],
      ),
    ),
  );
  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    String message,
  ) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 28),
    minVerticalPadding: 12,
    leading: Icon(icon, color: const Color(0xFF7F8A93)),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    trailing: const Icon(Icons.chevron_right),
    onTap: () => showTabSheet(context, title, message),
  );
}
