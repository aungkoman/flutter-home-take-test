import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/login_provider.dart';
import '../providers/auth_draft_provider.dart';
import '../providers/otp_verify_provider.dart';
import '../../domain/validators/auth_validators.dart';

class PhoneNumberPage extends ConsumerStatefulWidget {
  const PhoneNumberPage({super.key, this.mode = AuthEntryMode.login});
  final AuthEntryMode mode;

  @override
  ConsumerState<PhoneNumberPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<PhoneNumberPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = ref.read(authDraftProvider).phone;
    _phoneController.addListener(() {
      ref.read(authDraftProvider.notifier).setPhone(_phoneController.text);
    });
  }

  @override
  void didUpdateWidget(covariant PhoneNumberPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode != widget.mode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) ref.invalidate(loginProvider);
      });
    }
  }

  void _registerThisPhone() {
    ref.invalidate(loginProvider);
    context.go('/login?mode=register');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) {
      log(
        'PhoneNumberPage._submit: form validation failed; no login call',
        name: 'auth.login',
      );
      return;
    }
    log(
      'PhoneNumberPage._submit -> LoginNotifier.login '
      '| input String phone=${_phoneController.text}',
      name: 'auth.login',
    );
    await ref
        .read(loginProvider.notifier)
        .login(_phoneController.text, mode: widget.mode);
    log(
      'PhoneNumberPage._submit <- Future<void> completed',
      name: 'auth.login',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the provider for side-effects (Navigation)
    ref.listen<AsyncValue<UserEntity?>>(loginProvider, (previous, next) {
      final UserEntity? returnedUser = next.value;
      log(
        'PhoneNumberPage.ref.listen <- AsyncValue<UserEntity?> '
        '| runtime=${next.runtimeType}, loading=${next.isLoading}, '
        'error=${next.error}, userId=${returnedUser?.id}, '
        'name=${returnedUser?.firstName} ${returnedUser?.lastName}, '
        'phone=${returnedUser?.phone}, points=${returnedUser?.currentPoints}, '
        'tier=${returnedUser?.member.name}',
        name: 'auth.login',
      );
      // Check if we just finished loading and successfully got a user
      if (previous?.isLoading == true &&
          next is AsyncData<UserEntity?> &&
          next.value != null &&
          ref.read(loginProvider.notifier).requestedMode == widget.mode) {
        ref.invalidate(otpVerifyProvider);
        context.push('/otp');
      }
    });

    final AsyncValue<UserEntity?> loginState = ref.watch(loginProvider);
    final UserEntity? user = loginState.value;
    final String? errorMessage = ref.read(loginProvider.notifier).errorMessage;
    final bool isLoading = loginState.isLoading;

    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: appColors.blushBackground,
      appBar: AppBar(
        leadingWidth: 72,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppSpacing.xl),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xl),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: colorScheme.primary,
                        backgroundColor: colorScheme.secondary,
                      ),
                    )
                  : Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary,
                          width: 4,
                        ),
                        color: colorScheme.secondary,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xl),
                // Header Text
                Text('Enter your phone\nnumber', style: textTheme.displaySmall),
                const SizedBox(height: AppSpacing.xxl),

                // Input Field Container
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppRadii.card),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 16.0),
                        child: Text(
                          '+95',
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: 18,
                            color: appColors.textMuted,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          key: const ValueKey('auth-phone'),
                          controller: _phoneController,
                          enabled: !isLoading,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.telephoneNumber],
                          style: textTheme.bodyLarge?.copyWith(fontSize: 18),
                          decoration: const InputDecoration(
                            hintText: '09254135592',
                            filled: false,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          validator: AuthValidators.phone,
                          onFieldSubmitted: (_) => _submit(),
                        ),
                      ),
                      const SizedBox(width: 20), // Right padding for input
                    ],
                  ),
                ),

                // Error Message / User Card Display
                if (!isLoading && errorMessage != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    errorMessage,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ] else if (!isLoading && user != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                ],

                if (!isLoading &&
                    ref.read(loginProvider.notifier).isUnregisteredPhone)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: _registerThisPhone,
                      child: const Text('Register this number'),
                    ),
                  ),
                const Spacer(),

                // Continue Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _submit,
                    child: Text(
                      isLoading ? 'CHECKING…' : 'CONTINUE',
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 16,
                        letterSpacing: 1.2,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // Footer Text
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: textTheme.labelSmall?.copyWith(fontSize: 12),
                    children: [
                      const TextSpan(
                        text: 'By continuing, you acknowledge that you have read and agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms of Use',
                        style: TextStyle(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(
                          color: colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
