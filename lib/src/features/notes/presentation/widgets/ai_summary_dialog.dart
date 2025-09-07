import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/note_summary_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_spacing.dart';
import '../../../../core/di/injection_container.dart';

class AISummaryDialog extends StatelessWidget {
  final String content;

  const AISummaryDialog({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NoteSummaryCubit>()..summarizeNote(content),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(AppSpacing.heightLg),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.auto_awesome_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: AppSpacing.widthMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Özeti',
                            style: AppTextStyles.headlineSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppSpacing.heightXs),
                          Text(
                            'Notunuzun akıllı özeti',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => Navigator.of(context).pop(),
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Flexible(
                child: BlocBuilder<NoteSummaryCubit, NoteSummaryState>(
                  builder: (context, state) {
                    if (state is NoteSummaryLoading) {
                      return _buildLoadingState();
                    } else if (state is NoteSummaryLoaded) {
                      return _buildLoadedState(state);
                    } else if (state is NoteSummaryError) {
                      return _buildErrorState(state);
                    } else {
                      return _buildInitialState();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.heightLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: AppSpacing.heightLg),
          Text(
            'AI özetiniz hazırlanıyor...',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSpacing.heightSm),
          Text(
            'Bu işlem birkaç saniye sürebilir',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(NoteSummaryLoaded state) {
    final summary = state.summary;
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.heightLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Özet
          _buildSection(
            title: 'Özet',
            icon: Icons.summarize_rounded,
            child: Container(
              padding: EdgeInsets.all(AppSpacing.heightMd),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Text(
                summary.summary,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ),
          ),

          SizedBox(height: AppSpacing.heightLg),

          // Anahtar Noktalar
          if (summary.keyPoints.isNotEmpty) ...[
            _buildSection(
              title: 'Anahtar Noktalar',
              icon: Icons.key_rounded,
              child: Container(
                padding: EdgeInsets.all(AppSpacing.heightMd),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: summary.keyPoints.map((point) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: AppSpacing.heightSm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          SizedBox(width: AppSpacing.widthSm),
                          Expanded(
                            child: Text(
                              point,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: AppSpacing.heightLg),
          ],

          // İstatistikler
          _buildSection(
            title: 'İstatistikler',
            icon: Icons.analytics_rounded,
            child: Container(
              padding: EdgeInsets.all(AppSpacing.heightMd),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.blue.shade200,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      'Orijinal',
                      '${summary.originalWordCount} kelime',
                      Icons.description_rounded,
                      Colors.blue,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.blue.shade200,
                  ),
                  Expanded(
                    child: _buildStatItem(
                      'Özet',
                      '${summary.wordCount} kelime',
                      Icons.compress_rounded,
                      Colors.green,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.blue.shade200,
                  ),
                  Expanded(
                    child: _buildStatItem(
                      'Sıkıştırma',
                      '${((1 - summary.wordCount / summary.originalWordCount) * 100).toInt()}%',
                      Icons.trending_down_rounded,
                      Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(NoteSummaryError state) {
    return Builder(
      builder: (context) => Padding(
        padding: EdgeInsets.all(AppSpacing.heightLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.red.shade200,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: Colors.red.shade400,
                size: 48,
              ),
            ),
            SizedBox(height: AppSpacing.heightLg),
            Text(
              'Özetleme Başarısız',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppSpacing.heightSm),
            Text(
              state.message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.heightLg),
            ElevatedButton.icon(
              onPressed: () {
                context.read<NoteSummaryCubit>().summarizeNote(content);
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Tekrar Dene'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.widthLg,
                  vertical: AppSpacing.heightMd,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.heightLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
          SizedBox(height: AppSpacing.heightLg),
          Text(
            'AI Özeti Hazırlanıyor',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 20,
            ),
            SizedBox(width: AppSpacing.widthSm),
            Text(
              title,
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.heightSm),
        child,
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 20,
        ),
        SizedBox(height: AppSpacing.heightXs),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppSpacing.heightXs),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
