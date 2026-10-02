import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/loading_overlay.dart';

/// Registration page with email, password, and display name fields
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    // Clear any previous errors
    ref.read(authNotifierProvider.notifier).clearError();

    if (_formKey.currentState?.validate() ?? false) {
      await ref.read(authNotifierProvider.notifier).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            displayName: _nameController.text.trim(),
          );

      // Check the result
      if (mounted) {
        final authState = ref.read(authNotifierProvider);
        if (authState.state == AuthState.authenticated) {
          // Navigate to chat list (will be handled by auth_wrapper)
          Navigator.of(context).pop();
        } else if (authState.state == AuthState.error) {
          // Show error message
          _showErrorDialog(authState.errorMessage ?? AppConstants.errorGeneric);
        }
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'خطأ',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
        content: Text(
          _parseErrorMessage(message),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'حسناً',
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
    );
  }

  String _parseErrorMessage(String message) {
    // Parse Firebase error codes to Arabic messages
    if (message.contains('email-already-in-use')) {
      return AppConstants.errorEmailInUse;
    } else if (message.contains('invalid-email')) {
      return AppConstants.errorInvalidEmail;
    } else if (message.contains('weak-password')) {
      return AppConstants.errorWeakPassword;
    } else if (message.contains('network-request-failed')) {
      return AppConstants.errorNetwork;
    } else if (message.contains('too-many-requests')) {
      return AppConstants.errorTooManyRequests;
    } else if (message.contains('operation-not-allowed')) {
      return AppConstants.errorOperationNotAllowed;
    }
    return AppConstants.errorGeneric;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.state == AuthState.loading;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppConstants.signUp),
          centerTitle: true,
        ),
        body: LoadingOverlay(
          isLoading: isLoading,
          message: 'جارٍ إنشاء الحساب...',
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),
                    
                    // App logo or title
                    Text(
                      AppConstants.appName,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      'إنشاء حساب جديد',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Display name field
                    CustomTextField(
                      label: AppConstants.displayName,
                      controller: _nameController,
                      validator: Validators.validateDisplayName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      enabled: !isLoading,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Email field
                    CustomTextField(
                      label: AppConstants.email,
                      controller: _emailController,
                      validator: Validators.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      enabled: !isLoading,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Password field
                    CustomTextField(
                      label: AppConstants.password,
                      controller: _passwordController,
                      validator: Validators.validatePassword,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      enabled: !isLoading,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Confirm password field
                    CustomTextField(
                      label: AppConstants.confirmPassword,
                      controller: _confirmPasswordController,
                      validator: (value) => Validators.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                      obscureText: _obscureConfirmPassword,
                      textInputAction: TextInputAction.done,
                      enabled: !isLoading,
                      onSubmitted: (_) => _handleRegister(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Register button
                    CustomButton(
                      text: AppConstants.signUp,
                      onPressed: _handleRegister,
                      isLoading: isLoading,
                      width: double.infinity,
                      height: 56,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Navigate to login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: isLoading ? null : () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'لديك حساب؟ سجل الدخول',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
