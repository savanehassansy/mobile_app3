import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jmoov/core/providers/app.dart';
import 'package:jmoov/helpers.dart';
import 'package:jmoov/palette.dart';
import 'package:jmoov/views/components/default_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double maxDebit = 15;
  double debit = 0;

  double get _progress => debit / maxDebit;

  _fetchDebit() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        debit = Random().nextDouble() * maxDebit;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDebit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const DefaultAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Wrap(
            runSpacing: 8,
            children: [
              const _UserCard(),
              const _ConnectionStateCard(),
              _ConnectionSpeedCard(progress: _progress, debit: debit),
              const _TimerCard(),
              const _PubCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PubCard extends StatelessWidget {
  const _PubCard();

  @override
  Widget build(BuildContext context) {
    ThemeData t = theme(context);

    return Card(
      elevation: 5,
      color: Palette.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "PUB",
              style: t.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontSize: 128,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerCard extends StatelessWidget {
  const _TimerCard();

  @override
  Widget build(BuildContext context) {
    ThemeData t = theme(context);

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "00:00:00:00",
              style: t.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 128), // Place for the timer image
            Text(
              "TEMPS RESTANT",
              style: t.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConnectionSpeedCard extends StatelessWidget {
  const _ConnectionSpeedCard({
    required double progress,
    required this.debit,
  }) : _progress = progress;

  final double _progress;
  final double debit;

  @override
  Widget build(BuildContext context) {
    ThemeData t = theme(context);

    return Card(
      color: Palette.accentColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "DÉBIT DE CONNEXION",
              style: t.textTheme.labelLarge?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.flip(
                  flipX: true,
                  child: SizedBox(
                    height: 128,
                    width: 128,
                    child: CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 16,
                      strokeCap: StrokeCap.round,
                      color: Palette.primaryColor,
                      backgroundColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: debit.toStringAsFixed(2),
                    style: t.textTheme.headlineLarge
                        ?.copyWith(color: Colors.white),
                    children: [
                      TextSpan(
                        text: '\nMb/s',
                        style: t.textTheme.labelLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ConnectionStateCard extends StatelessWidget {
  const _ConnectionStateCard();

  @override
  Widget build(BuildContext context) {
    ThemeData t = theme(context);

    return Card(
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(
              Icons.wifi_off,
              color: Colors.red,
              size: 64,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pas d'accès à internet",
                    style: t.textTheme.titleMedium?.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  ActionChip(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/subscription');
                    },
                    label: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Souscrire à un pass'),
                    ),
                    backgroundColor: Palette.accentColor,
                    labelStyle: t.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                    ),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
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

class _UserCard extends StatelessWidget {
  const _UserCard();

  @override
  Widget build(BuildContext context) {
    ThemeData t = theme(context);
    AppProvider provider = getProvider<AppProvider>(context);

    return Card(
      color: Palette.primaryColor,
      shadowColor: Palette.primaryColor.withOpacity(0.5),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 64,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.user!.fullName,
                    style: t.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        provider.homeInfos['site'],
                        style: t.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
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
