import 'package:flutter/material.dart';
import 'package:xyz/core/theme/app_colors.dart';

class CoachDetailPage extends StatelessWidget {
  const CoachDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Coach Profile", style: t.headlineMedium),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 52,
                backgroundColor: AppColors.surface,
                backgroundImage: const AssetImage("assets/img/bg.png"),
              ),
              const SizedBox(height: 16),
              Text(
                'Dr. Amelia Stone',
                textAlign: TextAlign.center,
                style: t.headlineLarge,
              ),
              const SizedBox(height: 6),
              Text(
                'Life Coach',
                style: t.bodyLarge!.copyWith(color: AppColors.accent),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_rounded, color: AppColors.accent, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    '4.9 (120 reviews)',
                    style: t.bodyMedium!.copyWith(color: AppColors.accent),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dr. Amelia Stone is a certified life coach with over 10 years of experience helping individuals achieve ther personal and professional goals. She specializes in mindfulness, stress management, and career development.",
                  style: t.bodyMedium,
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Specialties", style: t.titleLarge),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      ['Mindfulness', 'StressManagement', 'Carerr Development']
                          .map(
                            (c) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceAlt,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(c, style: t.labelMedium),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Languages", style: t.titleLarge),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: ['English', 'Spanish']
                      .map(
                        (c) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceAlt,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(c, style: t.labelMedium),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Pricing", style: t.titleLarge),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('\$150 / session', style: t.bodyMedium),
              ),
              Spacer(),
              SizedBox(
                height: 58,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Book Session', style: t.headlineMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
