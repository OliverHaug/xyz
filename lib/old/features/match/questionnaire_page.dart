import 'package:flutter/material.dart';
import 'package:xyz/core/theme/app_colors.dart';
import 'package:xyz/old/features/match/widgets/option_card.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key, this.step = 1, this.totalSteps = 5});

  final int step;
  final int totalSteps;

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  final List<String> options = const [
    'Personal Growth',
    'Career Development',
    'Relationship Improvement',
    'Stress Management',
    'Health & Wellness',
  ];

  final Set<int> selected = {};

  @override
  Widget build(BuildContext context) {
    final progress = widget.step / widget.totalSteps;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.step} of ${widget.totalSteps}',
                          style: t.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceAlt,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              LayoutBuilder(
                                builder: (context, c) => Container(
                                  height: 8,
                                  width: c.maxWidth * progress.clamp(0.0, 1.0),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'What are your primary goals for seeking coaching?',
                  style: t.headlineMedium,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Select all that apply', style: t.bodyMedium),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => OptionCard(
                    label: options[index],
                    selected: selected.contains(index),
                    onChanged: (v) {
                      setState(() {
                        if (v) {
                          selected.add(index);
                        } else {
                          selected.remove(index);
                        }
                      });
                    },
                  ),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemCount: options.length,
                ),
              ),
              SizedBox(
                height: 58,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Next', style: t.headlineMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
