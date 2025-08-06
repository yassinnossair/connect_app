// lib/src/presentation/pages/public_profile_page.dart

import 'package:flutter/material.dart';

class PublicProfilePage extends StatelessWidget {
  const PublicProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // This page is designed to look good on the web, so we give it a
    // background color and center the content.
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          // We constrain the width to make it look better on wide screens (desktops).
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- Placeholder Data ---
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        // A placeholder image URL.
                        'https://i.pravatar.cc/300',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Yassin Eldeeb', // Placeholder Name
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Flutter Developer Intern', // Placeholder Title
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'ConnectSphere Inc.', // Placeholder Company
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    // Placeholder professional links.
                    _buildLinksSection(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to build the links section.
  Widget _buildLinksSection(BuildContext context) {
    // Placeholder list of links.
    final List<Map<String, String>> links = [
      {'type': 'LinkedIn', 'url': 'https://linkedin.com'},
      {'type': 'GitHub', 'url': 'https://github.com'},
      {'type': 'Portfolio', 'url': 'https://my-portfolio.com'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Connect',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // The Wrap widget arranges its children in rows or columns, wrapping
        // to the next line if there isn't enough space. Perfect for buttons.
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0, // Horizontal space between buttons
          runSpacing: 8.0, // Vertical space between rows of buttons
          children: links.map((link) {
            return ElevatedButton(
              onPressed: () {
                // In the next step, we'll add logic to open the URL.
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: Text(link['type']!),
            );
          }).toList(),
        ),
      ],
    );
  }
}