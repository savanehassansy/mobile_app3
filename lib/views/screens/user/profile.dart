import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmoov/core/models/user.dart';
import 'package:jmoov/core/providers/app.dart';
import 'package:jmoov/core/services/auth_service.dart';
import 'package:jmoov/helpers.dart';
import 'package:jmoov/views/components/default_appbar.dart';
import 'package:jmoov/views/components/labelled.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _activePanel = 0;
  bool _isLoading = false;

  // Text controllers
  final _firstNameCtl = TextEditingController();
  final _lastNameCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _countryCtl = TextEditingController();
  final _phoneNumberCtl = TextEditingController();
  final _currentPasswordCtl = TextEditingController();
  final _newPasswordCtl = TextEditingController();
  final _confirmNewPasswordCtl = TextEditingController();

  AuthService get _authService => AuthService.instance.of(context);
  AppProvider get _provider => getProvider<AppProvider>(context);

  @override
  void initState() {
    super.initState();
    _firstNameCtl.text = _user.firstname ?? '';
    _lastNameCtl.text = _user.lastname ?? '';
    _emailCtl.text = _user.email ?? '';
    _countryCtl.text = _user.country ?? '';
    _phoneNumberCtl.text = _user.mobile ?? '';
  }

  _setActivePanel(int index) {
    setState(() {
      _activePanel = index;
    });
  }

  User get _user => getProvider<AppProvider>(context).user!;

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
            Text('Mon profil',
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 16),
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                _setActivePanel(index);
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('Informations générales',
                          style: Theme.of(context).textTheme.titleLarge),
                    );
                  },
                  body: Form(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 24, left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Labelled(
                            label: "Prénom.s",
                            child: TextFormField(controller: _firstNameCtl),
                          ),
                          const SizedBox(height: 16),
                          Labelled(
                            label: "Nom",
                            child: TextFormField(controller: _lastNameCtl),
                          ),
                          const SizedBox(height: 16),
                          Labelled(
                            label: "Email",
                            child: TextFormField(
                                enabled: false, controller: _emailCtl),
                          ),
                          const SizedBox(height: 16),
                          Labelled(
                            label: "Pays",
                            child: TextFormField(controller: _countryCtl),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _updateGeneralInfo,
                            child: const Text('Modifier'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isExpanded: _activePanel == 0,
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('Numéro de téléphone',
                          style: Theme.of(context).textTheme.titleLarge),
                    );
                  },
                  body: Form(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 24, left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Numéro de téléphone',
                            ),
                            controller: _phoneNumberCtl,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Mot de passe actuel',
                            ),
                            obscureText: true,
                            controller: _currentPasswordCtl,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _updateMobile,
                            child: const Text('Modifier'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isExpanded: _activePanel == 1,
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text('Mot de passe',
                          style: Theme.of(context).textTheme.titleLarge),
                    );
                  },
                  body: Form(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 24, left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Mot de passe actuel',
                            ),
                            obscureText: true,
                            controller: _currentPasswordCtl,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Nouveau mot de passe',
                            ),
                            obscureText: true,
                            controller: _newPasswordCtl,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Confirmer le nouveau mot de passe',
                            ),
                            obscureText: true,
                            controller: _confirmNewPasswordCtl,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _updatePassword,
                            child: const Text('Modifier'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isExpanded: _activePanel == 2,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }

  _updateGeneralInfo() async {
    try {
      setState(() => _isLoading = true);
      User user = _provider.user!.copyWith(
        firstname: _firstNameCtl.text,
        lastname: _lastNameCtl.text,
        email: _emailCtl.text,
        country: _countryCtl.text,
      );
      await _authService.updateGeneralInfo(user);
      Fluttertoast.showToast(
        msg: 'Informations mises à jour',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 8,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 8,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  _updateMobile() async {
    try {
      setState(() => _isLoading = true);
      await _authService.updateMobile(
        _phoneNumberCtl.text,
        _currentPasswordCtl.text,
      );
      Fluttertoast.showToast(
        msg: 'Numéro de téléphone mis à jour',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 8,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 8,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  _updatePassword() async {
    try {
      setState(() => _isLoading = true);
      await _authService.updatePassword(
        _currentPasswordCtl.text,
        _newPasswordCtl.text,
        _confirmNewPasswordCtl.text,
      );
      Fluttertoast.showToast(
        msg: 'Mot de passe mis à jour',
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 8,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 8,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
