import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/features/home/bloc/home_bloc.dart';
import 'package:mam_solar/features/home/widgets/home_card.dart';
import 'package:mam_solar/features/home/widgets/recent_draft_card.dart';
import 'package:mam_solar/l10n/app_localizations.dart';
import 'package:sized_context/sized_context.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(sl<ProtocolRepository>())..add(const LoadHome()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.widthPx >= 600;
    final crossAxisCount = isTablet ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.accentYellow,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.asset('assets/logo.png'),
            ),
            const SizedBox(width: 8),
            const Text('mam-solarbau'),
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(const LoadHome());
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    delegate: SliverChildListDelegate([
                      HomeCard(
                        title: AppLocalizations.of(context)!.newProtocol,
                        icon: Icons.add_circle_outline,
                        color: AppColors.primaryGreen,
                        onTap: () => context.push('/protocol-type'),
                      ),
                      HomeCard(
                        title: AppLocalizations.of(context)!.savedDrafts,
                        icon: Icons.description_outlined,
                        badge: state.draftCount > 0 ? '${state.draftCount}' : null,
                        onTap: () => context.push('/drafts'),
                      ),
                      // HomeCard(
                      //   title: AppLocalizations.of(context)!.exportedPdfs,
                      //   icon: Icons.picture_as_pdf_outlined,
                      //   onTap: () {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //         content: Text('PDF export folder'),
                      //         behavior: SnackBarBehavior.floating,
                      //       ),
                      //     );
                      //   },
                      // ),
                      HomeCard(
                        title: AppLocalizations.of(context)!.settings,
                        icon: Icons.settings_outlined,
                        onTap: () => context.push('/settings'),
                      ),
                    ]),
                  ),
                ),
                if (state.recentDrafts.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        AppLocalizations.of(context)!.recentDrafts,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (state.recentDrafts.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: state.recentDrafts.length,
                        itemBuilder: (context, index) {
                          final draft = state.recentDrafts[index];
                          return RecentDraftCard(
                            protocol: draft,
                            onTap: () {
                              context.push('/form/${draft.type}/${draft.id}');
                            },
                          );
                        },
                      ),
                    ),
                  ),
                const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
              ],
            ),
          );
        },
      ),
    );
  }
}
