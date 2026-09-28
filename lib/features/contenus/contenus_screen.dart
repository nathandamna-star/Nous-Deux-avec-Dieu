import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import 'contenus_providers.dart';
import 'domain/contenu.dart';
import 'presentation/libelles.dart';

/// Bibliothèque : tous les contenus publiés, filtrables par type.
class ContenusScreen extends ConsumerStatefulWidget {
  const ContenusScreen({super.key});

  @override
  ConsumerState<ContenusScreen> createState() => _ContenusScreenState();
}

class _ContenusScreenState extends ConsumerState<ContenusScreen> {
  TypeContenu? _type;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final asynchrone = ref.watch(contenusPubliesProvider);
    final liste = (asynchrone.value ?? const <Contenu>[])
        .where((c) => _type == null || c.type == _type)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navContenus)),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                for (final t in [null, ...TypeContenu.values])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(t == null ? l10n.tous : l10n.typeContenu(t)),
                      selected: _type == t,
                      onSelected: (_) => setState(() => _type = t),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: asynchrone.isLoading && asynchrone.value == null
                ? const Center(child: CircularProgressIndicator())
                : liste.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        l10n.aucunContenu,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: liste.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final c = liste[i];
                      return Card(
                        child: ListTile(
                          title: Text(c.titre(langue)),
                          subtitle: Text(
                            '${l10n.typeContenu(c.type)} · '
                            '${l10n.themeContenu(c.theme)}',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push(Routes.contenu(c.id)),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
