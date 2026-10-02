import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import 'login_page.dart';

/// Auth wrapper that routes based on authentication state
class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    // Show loading screen while checking auth state
    if (authState.state == AuthState.loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // If authenticated, show chat list (placeholder for now)
    if (authState.state == AuthState.authenticated && authState.user != null) {
      return _ChatListPlaceholder(user: authState.user!);
    }

    // Otherwise, show login page
    return const LoginPage();
  }
}

/// Placeholder for chat list page (will be implemented in FEAT-004)
class _ChatListPlaceholder extends ConsumerWidget {
  final dynamic user;

  const _ChatListPlaceholder({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('المحادثات'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await ref.read(authNotifierProvider.notifier).signOut();
              },
              tooltip: 'تسجيل الخروج',
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'مرحباً ${user.displayName}!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'صفحة المحادثات قيد التطوير',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
