import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import '../../shared/widgets/connexion_requise.dart';
import '../accompagnement/accompagnement_providers.dart';
import '../auth/auth_providers.dart';
import 'presentation/conversation_screen.dart';

/// Onglet Messages : la conversation avec le coach (client), ou la liste des
/// conversations (coach).
class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    if (!ref.watch(estConnecteProvider)) {
      return ConnexionRequise(titre: l10n.navMessages);
    }
    if (!ref.watch(estCoachProvider)) {
      final acc = ref.watch(monAccompagnementProvider);
      if (acc.value != null) {
        return ConversationScreen(accId: acc.value!.id, integree: true);
      }
      return Scaffold(
        appBar: AppBar(title: Text(l10n.navMessages)),
        body: acc.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.messagesSansAccompagnement,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => context.push(Routes.demande),
                        child: Text(l10n.demanderAccompagnement),
                      ),
                    ],
                  ),
                ),
              ),
      );
    }

    // Coach : conversations, les plus récentes d'abord.
    final langue = Localizations.localeOf(context).toLanguageTag();
    final liste = [...?ref.watch(tousAccompagnementsProvider).value]
      ..sort(
        (a, b) => (b.dernierMessageLe ?? b.createdAt ?? DateTime(0)).compareTo(
          a.dernierMessageLe ?? a.createdAt ?? DateTime(0),
        ),
      );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navMessages)),
      body: liste.isEmpty
          ? Center(child: Text(l10n.aucuneConversation))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: liste.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final a = liste[i];
                return Card(
                  child: ListTile(
                    title: Text(a.nom),
                    subtitle: a.dernierMessage.isEmpty
                        ? null
                        : Text(
                            a.dernierMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (a.dernierMessageLe != null)
                          Text(
                            DateFormat.MMMd(langue).format(a.dernierMessageLe!),
                            style: theme.textTheme.labelSmall,
                          ),
                        if (a.nonLusCoach > 0)
                          Semantics(
                            label: l10n.nonLus(a.nonLusCoach),
                            child: Badge(label: Text('${a.nonLusCoach}')),
                          ),
                      ],
                    ),
                    onTap: () => context.push(Routes.conversation(a.id)),
                  ),
                );
              },
            ),
    );
  }
}
