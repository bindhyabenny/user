import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile Header Card
                Card(
                  elevation: 0,
                  color: colorScheme.primaryContainer.withValues(alpha: 0.45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          child: Text(
                            user.initials,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '@${user.username}',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Contact Information Section
                _SectionCard(
                  title: 'Contact Information',
                  icon: Icons.contact_mail_outlined,
                  children: [
                    _DetailRow(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: user.email,
                    ),
                    const Divider(height: 24),
                    _DetailRow(
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: user.phone,
                    ),
                    const Divider(height: 24),
                    _DetailRow(
                      icon: Icons.language_outlined,
                      label: 'Website',
                      value: user.website,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Address Section
                _SectionCard(
                  title: 'Address',
                  icon: Icons.location_on_outlined,
                  children: [
                    _DetailRow(
                      icon: Icons.home_outlined,
                      label: 'Street & Suite',
                      value: '${user.address.street}, ${user.address.suite}',
                    ),
                    const Divider(height: 24),
                    _DetailRow(
                      icon: Icons.location_city_outlined,
                      label: 'City & Zipcode',
                      value: '${user.address.city} (${user.address.zipcode})',
                    ),
                    const Divider(height: 24),
                    _DetailRow(
                      icon: Icons.explore_outlined,
                      label: 'Coordinates',
                      value:
                          'Lat: ${user.address.geo.lat}, Lng: ${user.address.geo.lng}',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Company Section
                _SectionCard(
                  title: 'Company',
                  icon: Icons.business_outlined,
                  children: [
                    _DetailRow(
                      icon: Icons.apartment_outlined,
                      label: 'Company Name',
                      value: user.company.name,
                    ),
                    const Divider(height: 24),
                    _DetailRow(
                      icon: Icons.format_quote_outlined,
                      label: 'Catchphrase',
                      value: '"${user.company.catchPhrase}"',
                    ),
                    const Divider(height: 24),
                    _DetailRow(
                      icon: Icons.trending_up_outlined,
                      label: 'Business Focus',
                      value: user.company.bs,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : 'N/A',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
