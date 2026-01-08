import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String email;
  final String? phone;
  final String currency;
  final String dateFormat;
  final double totalMonthlySpending;
  final String biggestCategory;
  final int transactionCount;
  final bool darkMode;
  final bool notificationsEnabled;
  final String language;
  final double profileCompletion;
  final VoidCallback onEditProfile;
  final VoidCallback onToggleDarkMode;
  final VoidCallback onToggleNotifications;
  final VoidCallback onChangeLanguage;
  final VoidCallback onChangePassword;
  final VoidCallback onManageCategories;
  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.email,
    this.phone,
    required this.currency,
    required this.dateFormat,
    required this.totalMonthlySpending,
    required this.biggestCategory,
    required this.transactionCount,
    required this.darkMode,
    required this.notificationsEnabled,
    required this.language,
    required this.profileCompletion,
    required this.onEditProfile,
    required this.onToggleDarkMode,
    required this.onToggleNotifications,
    required this.onChangeLanguage,
    required this.onChangePassword,
    required this.onManageCategories,
    required this.onLogout,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF7C3AED)),
            onPressed: onEditProfile,
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              CircleAvatar(
                radius: 36,
                backgroundColor: const Color(0xFF7C3AED),
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                  style: const TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                userName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                email,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              // Profile completion
              if (profileCompletion < 1.0)
                Column(
                  children: [
                    LinearProgressIndicator(
                      value: profileCompletion,
                      backgroundColor: Colors.grey[300],
                      color: const Color(0xFF7C3AED),
                      minHeight: 6,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Profile ${((profileCompletion * 100).round())}% complete',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              // User Info Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _infoRow(Icons.person, 'Name', userName),
                      _infoRow(Icons.email, 'Email', email),
                      if (phone != null && phone!.isNotEmpty)
                        _infoRow(Icons.phone, 'Phone', phone!),
                      _infoRow(Icons.attach_money, 'Currency', currency),
                      _infoRow(Icons.calendar_today, 'Date Format', dateFormat),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Expense Summary
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _summaryItem(
                        'Total This Month',
                        '\$${totalMonthlySpending.toStringAsFixed(2)}',
                        Icons.pie_chart,
                      ),
                      _summaryItem(
                        'Top Category',
                        biggestCategory,
                        Icons.category,
                      ),
                      _summaryItem(
                        'Transactions',
                        '$transactionCount',
                        Icons.receipt_long,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Settings
              _sectionTitle('Settings'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    SwitchListTile(
                      value: darkMode,
                      onChanged: (_) => onToggleDarkMode(),
                      title: const Text('Dark Mode'),
                      secondary: const Icon(Icons.dark_mode),
                    ),
                    SwitchListTile(
                      value: notificationsEnabled,
                      onChanged: (_) => onToggleNotifications(),
                      title: const Text('Notifications'),
                      secondary: const Icon(Icons.notifications),
                    ),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Language'),
                      subtitle: Text(language),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: onChangeLanguage,
                    ),
                    ListTile(
                      leading: const Icon(Icons.lock),
                      title: const Text('Change Password'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: onChangePassword,
                    ),
                    ListTile(
                      leading: const Icon(Icons.category),
                      title: const Text('Manage Categories'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: onManageCategories,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Security & Account
              _sectionTitle('Security & Account'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text('Logout'),
                      onTap: onLogout,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.delete_forever,
                        color: Colors.grey,
                      ),
                      title: const Text('Delete Account'),
                      onTap: onDeleteAccount,
                      subtitle: const Text(
                        'This action is permanent',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Privacy info
              Text(
                'Your data is private and secure. We never share your information.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Motivational message
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Keep tracking your expenses and take control of your financial future! 💪',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7C3AED), size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF7C3AED), size: 28),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color(0xFF7C3AED),
        ),
      ),
    );
  }
}
