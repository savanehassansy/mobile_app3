import 'package:flutter/material.dart';
import 'package:jmoov/core/models/bundle.dart';
import 'package:jmoov/core/services/subscriptions_service.dart';
import 'package:jmoov/palette.dart';
import 'package:jmoov/views/components/default_appbar.dart';
import 'package:jmoov/views/components/selector.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  static const routeName = '/subscription';

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _selectedPass = "1";
  List<Pass> _bundles = [];
  bool _loading = true;

  final SubscriptionsService _subscriptionsService =
      SubscriptionsService.instance;

  List<Bundle> get _subscriptions {
    Pass b = _bundles.firstWhere(
      (element) => element.catId == int.parse(_selectedPass),
    );
    return b.subscriptions;
  }

  _fetch() async {
    List<Pass> tpass = await _subscriptionsService.getBundles();

    setState(() {
      _bundles = tpass;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Selector(
                        label: "Choisis un forfait",
                        value: _selectedPass,
                        onChanged: (value) {
                          setState(() {
                            _selectedPass = value;
                          });
                        },
                        items: _bundles
                            .map((bundle) => SelectorItem(
                                label: bundle.catLabel!,
                                value: "${bundle.catId!}"))
                            .toList(),
                      ),
                      Divider(color: Colors.grey.shade300),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _subscriptions
                            .map((e) => _BundleButton(
                                  label: e.label!,
                                  price: e.amount!,
                                  onTap: () {
                                    _selectBundle(e.id!);
                                  },
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  _selectBundle(int bundle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        insetPadding: const EdgeInsets.all(16),
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
        content:
            Text("Voulez-vous acheter $bundle heure${bundle > 1 ? "s" : ""} ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Confirmer"),
          ),
        ],
      ),
    );
  }
}

class _BundleButton extends StatelessWidget {
  final String label;
  final int price;
  final void Function() onTap;

  const _BundleButton({
    required this.label,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Palette.primaryDark, width: 4),
      ),
      color: Palette.primaryColor,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Column(
                children: [
                  Text(
                    "$price",
                    style: const TextStyle(
                      color: Palette.primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      height: 1,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Text(
                    "FRCFA",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
