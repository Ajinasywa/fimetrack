import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menstrual_cycle_provider.dart';
import '../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image, size: 40);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () async {
                        await authProvider.signOut();
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(context, '/');
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Hai, ${user?.fullName ?? 'User'}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7B9C),
                  ),
                ),
                Consumer<MenstrualCycleProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.periodStartDate != null
                              ? 'Hari ke-${DateTime.now().difference(provider.periodStartDate!).inDays + 1} dari masa ${provider.currentPhase.toString().split('.').last}'
                              : 'Belum ada data menstruasi',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0F3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Icon(Icons.favorite, color: Color(0xFFFF7B9C)),
                                  SizedBox(width: 8),
                                  Text(
                                    'femiTrack',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFF7B9C),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF7B9C),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  provider.currentPhase.toString().split('.').last,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                provider.getTip(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF0F3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: CyclePhase.values.map((phase) {
                                    final isActive = provider.currentPhase == phase;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? const Color(0xFFFF7B9C)
                                              : const Color(0xFFFFE5EB),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          phase.toString().split('.').last,
                                          style: TextStyle(
                                            color: isActive ? Colors.white : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Akses cepat',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _QuickAccessButton(
                                  icon: Icons.calendar_today,
                                  label: 'Catat Haid',
                                  onTap: () => Navigator.pushNamed(context, '/calendar'),
                                ),
                                const SizedBox(width: 16),
                                _QuickAccessButton(
                                  icon: Icons.medical_services,
                                  label: 'Gejala',
                                  onTap: () => Navigator.pushNamed(context, '/calendar'),
                                ),
                                const SizedBox(width: 16),
                                _QuickAccessButton(
                                  icon: Icons.calendar_month,
                                  label: 'Kalender',
                                  onTap: () => Navigator.pushNamed(context, '/calendar'),
                                ),
                                const SizedBox(width: 16),
                                _QuickAccessButton(
                                  icon: Icons.mood,
                                  label: 'Track Mood',
                                  onTap: () => Navigator.pushNamed(context, '/calendar'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Edukasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Kalender',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/education');
              break;
            case 2:
              Navigator.pushNamed(context, '/calendar');
              break;
          }
        },
      ),
    );
  }
}

class _QuickAccessButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAccessButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFFF7B9C),
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}