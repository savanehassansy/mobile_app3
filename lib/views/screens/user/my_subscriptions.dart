import 'package:flutter/material.dart';
import 'package:jmoov/core/models/subscription.dart';
import 'package:jmoov/core/providers/app.dart';
import 'package:jmoov/core/services/subscriptions_service.dart';
import 'package:jmoov/helpers.dart';
import 'package:jmoov/palette.dart';
import 'package:jmoov/views/components/default_appbar.dart';

class MySubscriptionsScreen extends StatefulWidget {
  const MySubscriptionsScreen({super.key});

  static const routeName = '/my-subscriptions';

  @override
  State<MySubscriptionsScreen> createState() => _MySubscriptionsScreenState();
}

class _MySubscriptionsScreenState extends State<MySubscriptionsScreen> {
  List<Subscription> subscriptions = [];
  bool isLoading = true;

  SubscriptionsService get _subscriptionsService =>
      SubscriptionsService.instance;

  AppProvider get _provider => getProvider<AppProvider>(context);

  _fetchSubscriptions() async {
    setState(() => isLoading = true);
    subscriptions =
        await _subscriptionsService.getSubscriptions(_provider.token!);
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _fetchSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Mes souscriptions',
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Besoin d'un accès internet dans l'une de nos zones wifi ? Souscrire un pass.",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Palette.primaryColor,
                          ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FixedColumnWidth(100),
                          1: FixedColumnWidth(120),
                          2: FixedColumnWidth(100),
                          3: FixedColumnWidth(200),
                          4: FixedColumnWidth(200),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            children: const [
                              _HCell('PASS'),
                              _HCell('MONTANT'),
                              _HCell('STATUT'),
                              _HCell('TEMPS DE CONNEXION'),
                              _HCell('SOUSCRIPTION DU'),
                            ],
                          ),
                          ...subscriptions
                              .map((subscription) => row(subscription))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  TableRow row(Subscription subscription) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            subscription.passCategory!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child:
              Text('${subscription.amount} FCFA', textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: _Badge(subscription.status!),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            getReadableDuration(subscription.time!),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Du ${subscription.startAt} au ${subscription.endAt}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  const _Badge(this.label);

  MaterialColor get color {
    switch (label.toLowerCase()) {
      case 'en cours':
        return Colors.green;
      case 'expiré(e)':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: color.shade50,
      label: Text(
        label,
        style: TextStyle(color: color.shade900),
      ),
      largeSize: 24,
    );
  }
}

class _HCell extends StatelessWidget {
  final String label;

  const _HCell(this.label);

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.green.shade700,
        ),
        textAlign: TextAlign.center,
      ),
    ));
  }
}

String getReadableDuration(int duration) {
  final months = duration ~/ 2592000;
  final days = duration ~/ 86400;
  final hours = duration ~/ 3600;
  final minutes = (duration % 3600) ~/ 60;
  final seconds = duration % 60;

  if (months > 0) return '${months.toString().padLeft(2, '0')} mois';
  if (days > 0) return '${days.toString().padLeft(2, '0')} jours';
  if (hours > 0) return '${hours.toString().padLeft(2, '0')} heures';
  if (minutes > 0) return '${minutes.toString().padLeft(2, '0')} minutes';
  if (seconds > 0) return '${seconds.toString().padLeft(2, '0')} secondes';

  return '${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
}
