import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../utils/validators.dart';
import '../../utils/constants.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/loading_overlay.dart';
import 'register_page.dart';

/// Login page with email, password, and remember me option
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadRememberedCredentials() async {
    final cacheService = ref.read(cacheServiceProvider);
    final rememberedEmail = await cacheService.getString('remembered_email');
    final rememberedPassword = await cacheService.getString('remembered_password');
    final rememberMeFlag = await cacheService.getBool('remember_me') ?? false;

    if (rememberedEmail != null && rememberedPassword != null && rememberMeFlag) {
      setState(() {
        _emailController.text = rememberedEmail;
        _passwordController.text = rememberedPassword;
        _rememberMe = true;
      });
    }
  }

  Future<void> _saveRememberedCredentials() async {
    final cacheService = ref.read(cacheServiceProvider);
    
    if (_rememberMe) {
      await cacheService.saveString('remembered_email', _emailController.text.trim());
      await cacheService.saveString('remembered_password', _passwordController.text);
      await cacheService.saveBool('remember_me', true);
    } else {
      await cacheService.remove('remembered_email');
      await cacheService.remove('remembered_password');
      await cacheService.saveBool('remember_me', false);
    }
  }

  Future<void> _handleLogin() async {
    // Clear any previous errors
    ref.read(authNotifierProvider.notifier).clearError();

    if (_formKey.currentState?.validate() ?? false) {
      // Save credentials if remember me is checked
      await _saveRememberedCredentials();

      await ref.read(authNotifierProvider.notifier).signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      // Check the result
      if (mounted) {
        final authState = ref.read(authNotifierProvider);
        if (authState.state == AuthState.authenticated) {
          // Navigation will be handled by auth_wrapper
          // Just clear the form
          _emailController.clear();
          _passwordController.clear();
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
    if (message.contains('user-not-found')) {
      return AppConstants.errorUserNotFound;
    } else if (message.contains('wrong-password')) {
      return AppConstants.errorWrongPassword;
    } else if (message.contains('invalid-email')) {
      return AppConstants.errorInvalidEmail;
    } else if (message.contains('user-disabled')) {
      return AppConstants.errorUserDisabled;
    } else if (message.contains('network-request-failed')) {
      return AppConstants.errorNetwork;
    } else if (message.contains('too-many-requests')) {
      return AppConstants.errorTooManyRequests;
    } else if (message.contains('operation-not-allowed')) {
      return AppConstants.errorOperationNotAllowed;
    }
    return AppConstants.errorGeneric;
  }

  void _navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.state == AuthState.loading;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppConstants.signIn),
          centerTitle: true,
        ),
        body: LoadingOverlay(
          isLoading: isLoading,
          message: 'جارٍ تسجيل الدخول...',
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 48),
                    
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
                      'مرحباً بك مرة أخرى',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 48),
                    
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
                      textInputAction: TextInputAction.done,
                      enabled: !isLoading,
                      onSubmitted: (_) => _handleLogin(),
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
                    
                    const SizedBox(height: 8),
                    
                    // Remember me checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: isLoading ? null : (value) {
                            setState(() {
                              _rememberMe = value ?? false;
                            });
                          },
                        ),
                        const Text('تذكرني'),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Login button
                    CustomButton(
                      text: AppConstants.signIn,
                      onPressed: _handleLogin,
                      isLoading: isLoading,
                      width: double.infinity,
                      height: 56,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Navigate to register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: isLoading ? null : _navigateToRegister,
                          child: const Text(
                            'ليس لديك حساب؟ سجل الآن',
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
