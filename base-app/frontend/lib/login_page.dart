import 'package:flutter/material.dart';
import 'package:frontend/controllers/login_controller.dart';
import 'package:frontend/utils/utils.dart';
import 'package:frontend/widgets/dashboard.dart';

class LoginPage extends StatefulWidget {
  final Widget? emblem;
  const LoginPage({super.key, this.emblem});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// Manages the 'login section' view.
class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _hidePasswordInput = true;
  bool _isLoggingIn = false;
  bool _isSignedIn = false;
  // ignore: unused_field
  bool _isAdmin = false;
  RegExp validEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static final TextEditingController usernameController =
      TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();

  static final FocusNode usernameFocus = FocusNode();
  static final FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
            child: _isLoggingIn
                ? Container(
                    margin: EdgeInsets.only(top: queryData.size.height / 7.5),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator())
                : Container(
                    margin: EdgeInsets.only(top: queryData.size.height / 7.5),
                    alignment: Alignment.center,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 350),
                      child: Column(
                        children: getWidgets(context, queryData),
                      ),
                    ))));
  }

  /// Aggregates all widgets in a list.
  List<Widget> getWidgets(BuildContext context, MediaQueryData queryData) {
    final List<Widget> widgets = [];

    widgets.add(
        Padding(padding: EdgeInsets.only(bottom: queryData.size.height / 70)));
    widgets.add(createTitle(context, queryData));
    widgets.add(
        Padding(padding: EdgeInsets.only(bottom: queryData.size.height / 35)));
    widgets.add(createLoginForm(context, queryData));

    return widgets;
  }

  /// Creates the title for the login menu.
  Widget createTitle(BuildContext context, MediaQueryData queryData) {
    return Column(children: [
      Padding(padding: EdgeInsets.only(bottom: queryData.size.height / 30)),
      widget.emblem ?? Image.asset(path("images/maersk_e.png")),
      Padding(padding: EdgeInsets.only(bottom: queryData.size.height / 20)),
      const Text(
        'Sign In to Maersk E-commerce',
        style: TextStyle(fontSize: 23),
      ),
    ]);
  }

  /// Creates the widgets for the user input fields.
  Widget createLoginForm(BuildContext context, MediaQueryData queryData) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
            padding: EdgeInsets.only(
                left: queryData.size.width / 45,
                right: queryData.size.width / 45,
                top: queryData.size.height / 40,
                bottom: queryData.size.height / 45),
            child: Column(
              children: [
                createLabel(context, 'Username or email'),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: queryData.size.height / 80)),
                createUsernameInput(context),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: queryData.size.height / 25)),
                createLabel(context, 'Password'),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: queryData.size.height / 80)),
                createPasswordInput(),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: queryData.size.height / 35)),
                createLogInButton(context)
              ],
            )),
      ),
    );
  }

  /// Creates the input labels.
  Widget createLabel(BuildContext context, String labelText) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        labelText,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Creates the widget for the username input.
  Widget createUsernameInput(BuildContext context) {
    return TextFormField(
        style: const TextStyle(fontSize: 20),
        autocorrect: false,
        autofocus: true,
        controller: usernameController,
        focusNode: usernameFocus,
        onFieldSubmitted: (term) {
          usernameFocus.unfocus();
          FocusScope.of(context).requestFocus(passwordFocus);
        },
        decoration: textFieldDecoration(),
        validator: (String? value) => validateUsername(value));
  }

  /// Creates the widget for the password input.
  Widget createPasswordInput() {
    return TextFormField(
        style: const TextStyle(fontSize: 20),
        autocorrect: false,
        obscureText: _hidePasswordInput,
        enableInteractiveSelection: !_hidePasswordInput,
        controller: passwordController,
        focusNode: passwordFocus,
        onFieldSubmitted: (term) {
          passwordFocus.unfocus();
          _login();
        },
        decoration: passwordFieldDecoration(),
        validator: (String? value) =>
            (value == null || value.isEmpty) ? 'Password is required' : null);
  }

  /// Creates the widget for the user to confirm the inputted login info
  Widget createLogInButton(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: const Text('Log In',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            textAlign: TextAlign.center),
        onPressed: () {
          _login();
        },
      ),
    );
  }

  /// Decoration for the username field.
  InputDecoration textFieldDecoration() {
    return const InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 82, 81, 81))),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2)));
  }

  /// Decoration for the password field.
  InputDecoration passwordFieldDecoration() {
    final genericDecoration = textFieldDecoration();
    return InputDecoration(
        enabledBorder: genericDecoration.enabledBorder,
        border: genericDecoration.border,
        focusedBorder: genericDecoration.focusedBorder,
        suffixIcon: IconButton(
          icon: Icon(
            _hidePasswordInput ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _toggleHidePasswordInput,
          color: const Color.fromARGB(255, 82, 81, 81),
        ));
  }

  /// Makes the password input view hidden.
  void _toggleHidePasswordInput() {
    setState(() {
      _hidePasswordInput = !_hidePasswordInput;
    });
  }

  /// Handles the login.
  void _login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoggingIn = true;
      });

      login(username, password, usernameController, passwordController)
          .then((loggedIn) {
        setState(() {
          _isLoggingIn = false;
          _isSignedIn = loggedIn[0];
          _isAdmin = loggedIn[1];
        });

        if (_isSignedIn) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Dashboard(
                    loggedUserName: username,
                  )));
        }
      });
    }
  }

  /// Validates the username input.
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    } else if (username.contains('@') && !validEmail.hasMatch(username)) {
      return 'Invalid email';
    }

    return null;
  }
}
