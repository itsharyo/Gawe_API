import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  final Color framework7Purple = const Color(0xFF9147FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dialog',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Deskripsi
            const Text(
              'There are 1:1 replacements of native Alert, Prompt and Confirm modals. They support callbacks, have very easy api and can be combined with each other. Check these examples:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // --- 1. Basic Dialogs (Alert, Confirm, Prompt, Login, Password) ---
            // Baris 1: Alert, Confirm, Prompt (Lebar dibagi 3)
            Row(
              children: [
                Expanded(
                  child: _buildPurpleButton(
                    'Alert',
                    () => _showAlert(
                      context,
                      title: 'Framework7',
                      content: 'Hello!',
                    ),
                    isFullWidth: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPurpleButton(
                    'Confirm',
                    () => _showConfirm(context),
                    isFullWidth: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPurpleButton(
                    'Prompt',
                    () => _showPrompt(context),
                    isFullWidth: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // Jarak antar baris tombol
            // Baris 2: Login, Password (Lebar dibagi 2)
            Row(
              children: [
                Expanded(
                  child: _buildPurpleButton(
                    'Login',
                    () => _showLogin(context),
                    isFullWidth: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPurpleButton(
                    'Password',
                    () => _showPassword(context),
                    isFullWidth: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- 2. Vertical Buttons ---
            _buildTitle('Vertical Buttons'),
            _buildPurpleButton(
              'Vertical Buttons',
              () => _showVerticalButtons(context),
              isFullWidth: true,
            ),
            const SizedBox(height: 24),

            // --- 3. Preloader Dialog ---
            _buildTitle('Preloader Dialog'),
            Row(
              children: [
                Expanded(
                  child: _buildPurpleButton(
                    'Preloader',
                    () => _showPreloader(context),
                    isFullWidth: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPurpleButton(
                    'Custom Text',
                    () => _showPreloader(context, text: 'Loading Data...'),
                    isFullWidth: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- 4. Progress Dialog ---
            _buildTitle('Progress Dialog'),
            Row(
              children: [
                Expanded(
                  child: _buildPurpleButton(
                    'Infinite',
                    () => _showInfiniteProgress(context),
                    isFullWidth: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildPurpleButton(
                    'Determined',
                    () => _showDeterminedProgress(context),
                    isFullWidth: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- 5. Dialogs Stack ---
            _buildTitle('Dialogs Stack'),
            const Text(
              'This feature doesn\'t allow to open multiple dialogs at the same time, and will automatically open next dialog when you close the current one. Such behavior is similar to browser native dialogs:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            _buildPurpleButton(
              'Open Multiple Alerts',
              () => _showDialogsStack(context),
              isFullWidth: true,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Widget Pembantu ---

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: framework7Purple,
        ),
      ),
    );
  }

  Widget _buildPurpleButton(
    String text,
    VoidCallback onPressed, {
    bool isFullWidth = false,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: framework7Purple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  // --- Fungsi Dialog ---

  void _showAlert(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: framework7Purple)),
          ),
        ],
      ),
    );
  }

  void _showConfirm(BuildContext context) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Framework7'),
        content: const Text('Are you feel good today?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('OK', style: TextStyle(color: framework7Purple)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      _showAlert(context, title: 'Framework7', content: 'Great!');
    }
  }

  void _showPrompt(BuildContext context) async {
    TextEditingController controller = TextEditingController();

    String? name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Framework7'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "What is your name?"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text('OK', style: TextStyle(color: framework7Purple)),
          ),
        ],
      ),
    );

    if (name != null && name.isNotEmpty) {
      _showPromptConfirmChain(context, name: name);
    }
  }

  void _showPromptConfirmChain(
    BuildContext context, {
    required String name,
  }) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Framework7'),
        content: Text('Are you sure that your name is $name?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('OK', style: TextStyle(color: framework7Purple)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _showAlert(
        context,
        title: 'Framework7',
        content: 'Ok, your name is $name',
      );
    }
  }

  void _showLogin(BuildContext context) async {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    bool? submitted = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Framework7'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter your username and password'),
            const SizedBox(height: 15),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Username",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: framework7Purple),
                ),
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "Password"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('OK', style: TextStyle(color: framework7Purple)),
          ),
        ],
      ),
    );

    if (submitted == true) {
      String username = usernameController.text.isEmpty
          ? 'N/A'
          : usernameController.text;
      String password = passwordController.text.isEmpty
          ? 'N/A'
          : passwordController.text;

      _showAlert(
        context,
        title: 'Framework7',
        content: 'Thank you!\nUsername: $username\nPassword: $password',
      );
    }
  }

  void _showPassword(BuildContext context) async {
    TextEditingController controller = TextEditingController();

    String? passwordInput = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Framework7'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter your password'),
            TextField(
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: framework7Purple),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text('OK', style: TextStyle(color: framework7Purple)),
          ),
        ],
      ),
    );

    if (passwordInput != null) {
      String displayedPassword = passwordInput.isEmpty
          ? '[kosong]'
          : passwordInput;

      _showAlert(
        context,
        title: 'Framework7',
        content: 'Password yang dimasukkan: $displayedPassword',
      );
    }
  }

  void _showVerticalButtons(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Vertical Buttons', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: Text(
                'Button 1',
                style: TextStyle(fontSize: 16, color: framework7Purple),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: Text(
                'Button 2',
                style: TextStyle(fontSize: 16, color: framework7Purple),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: Text(
                'Button 3',
                style: TextStyle(fontSize: 16, color: framework7Purple),
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 0,
        ),
        titlePadding: const EdgeInsets.only(top: 24, bottom: 8),
        actions: const [],
      ),
    );
  }

  void _showPreloader(BuildContext context, {String text = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Text(text),
          ],
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  void _showInfiniteProgress(BuildContext context) {
    _showPreloader(context, text: 'Fetching...');
  }

  void _showDeterminedProgress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Processing... (Simulasi)'),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: 0.75, color: framework7Purple),
          ],
        ),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  void _showDialogsStack(BuildContext context) async {
    // Alert 1
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert 1'),
        content: const Text('Ini alert pertama.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: framework7Purple)),
          ),
        ],
      ),
    );

    // Alert 2
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert 2'),
        content: const Text('Ini alert kedua.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: framework7Purple)),
          ),
        ],
      ),
    );

    // Alert 3
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert 3'),
        content: const Text('Ini alert ketiga.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK', style: TextStyle(color: framework7Purple)),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Semua dialog stack sudah ditampilkan.')),
    );
  }
}
