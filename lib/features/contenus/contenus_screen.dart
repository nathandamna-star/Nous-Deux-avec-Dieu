import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../l10n/app_localizations.dart';
import '../auth/auth_providers.dart';
import 'contenus_providers.dart';
import 'domain/contenu.dart';
import 'presentation/libelles.dart';
import '../parcours/presentation/liste_parcours.dart';

/// Bibliothèque : tous les contenus publiés, filtrables par type.
class ContenusScreen extends ConsumerStatefulWidget {
  const ContenusScreen({super.key});

  @override
  ConsumerState<ContenusScreen> createState() => _ContenusScreenState();
}

class _ContenusScreenState extends ConsumerState<ContenusScreen> {
  TypeContenu? _type;
  var _parcours = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final langue = Localizations.localeOf(context).languageCode;
    final asynchrone = ref.watch(contenusPubliesProvider);
    final liste = (asynchrone.value ?? const <Contenu>[])
        .where((c) => _type == null || c.type == _type)
        .toList();

    final coach = ref.watch(estCoachProvider);
    return Scaffold(
      // Coach : ajouter un audio ou une vidéo directement ici.
      floatingActionButton: coach
          ? FloatingActionButton.extended(
              onPressed: () => context.push(
                '${Routes.nouveauContenu}?type='
                '${_type == TypeContenu.video ? 'video' : 'audio'}',
              ),
              icon: const Icon(Icons.add),
              label: Text(l10n.ajouterAudioVideo),
            )
          : null,
      appBar: AppBar(
        title: Text(l10n.navContenus),
        actions: [
          IconButton(
            tooltip: l10n.mesLivres,
            icon: const Icon(Icons.menu_book_outlined),
            onPressed: () => context.push(Routes.livresContenus),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    avatar: const Icon(Icons.route_outlined),
                    label: Text(l10n.parcours),
                    selected: _parcours,
                    onSelected: (_) => setState(() => _parcours = true),
                  ),
                ),
                for (final t in [null, ...TypeContenu.values])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(t == null ? l10n.tous : l10n.typeContenu(t)),
                      selected: !_parcours && _type == t,
                      onSelected: (_) => setState(() {
                        _parcours = false;
                        _type = t;
                      }),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: _parcours
                ? const ListeParcours()
                : asynchrone.isLoading && asynchrone.value == null
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
