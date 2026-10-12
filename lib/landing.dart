import 'package:flutter/material.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // Controls whether the "welcome" text or the "start" CTA is showing.
  bool _showCta = false;

  // Controls the fade-in of the whole column on first load.
  double _opacity = 0.0;

  // Controls the animated size of the logo circle.
  double _logoSize = 80.0;

  @override
  void initState() {
    super.initState();

    // 1) Fade the whole page in shortly after it loads.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _opacity = 1.0);
    });

    // 2) Grow the logo circle from 80 -> 120 after a small delay.
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() => _logoSize = 120.0);
    });

    // 3) Swap the text block to the CTA after a bit longer.
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() => _showCta = true);
    });
  }

  void _goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFFEDEFF3),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),

              // ✨ 1) AnimatedOpacity — fades the whole column in.
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeIn,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ✨ 2) AnimatedContainer — logo circle smoothly
                    //    resizes from 80 -> 120.
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutBack,
                      width: _logoSize,
                      height: _logoSize,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A0E0E),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.18),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.fitness_center,
                        size: _logoSize * 0.5,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ✨ 3) AnimatedCrossFade — swaps "CROSSFIT" text
                    //    for the "Get Started" CTA automatically.
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 600),
                      firstCurve: Curves.easeOut,
                      secondCurve: Curves.easeIn,
                      sizeCurve: Curves.easeOutCubic,
                      crossFadeState: _showCta
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'CROSSFIT',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4,
                              color: Color(0xFF2A0E0E),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Train hard. Stay strong. Repeat.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      secondChild: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Ready to start?',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A0E0E),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Sign in and track your progress.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _goToLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2A0E0E),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: _goToLogin,
                            child: const Text(
                              'I already have an account',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF2A0E0E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Keeps some breathing room on landscape screens.
                    SizedBox(height: isLandscape ? 16 : 0),
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