import 'package:flutter/material.dart';
import 'package:xyz/core/theme/app_colors.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;

    final matches = [
      {"name": "Dr. Anya Sharma", "match": 95, "image": "assets/anya.png"},
      {"name": "Dr. Ben Carter", "match": 92, "image": "assets/ben.png"},
      {"name": "Dr. Chloe Davis", "match": 90, "image": "assets/chloe.png"},
      {"name": "Dr. Ethan Miller", "match": 88, "image": "assets/ethan.png"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Matches", style: t.headlineMedium),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: matches.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = matches[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage(item["image"]! as String),
                backgroundColor: Colors.grey.shade200,
              ),
              title: Text(item["name"]! as String, style: t.titleMedium),
              subtitle: Text(
                "${item["match"]}% match",
                style: t.bodyMedium!.copyWith(color: AppColors.accent),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.black45),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
