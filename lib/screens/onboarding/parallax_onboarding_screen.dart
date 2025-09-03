import 'package:flutter/material.dart';
import '../login_screen.dart';
import '../signup_screen.dart';
import '../../theme/app_theme.dart';

class ParallaxOnboardingScreen extends StatefulWidget {
  const ParallaxOnboardingScreen({super.key});

  @override
  State<ParallaxOnboardingScreen> createState() => _ParallaxOnboardingScreenState();
}

class _ParallaxOnboardingScreenState extends State<ParallaxOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  double _currentPageValue = 0.0;
  final int _totalPages = 6;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_updateParallax);
  }

  void _updateParallax() {
    if (_pageController.hasClients) {
      setState(() {
        _currentPageValue = _pageController.page ?? 0.0;
      });
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_updateParallax);
    _pageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Parallax Background
          _buildParallaxBackground(),
          // Content overlay
          SafeArea(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _totalPages,
              onPageChanged: (index) => setState(() => _currentPageIndex = index),
              itemBuilder: (_, index) => _buildOnboardingPage(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParallaxBackground() {
    // Calculate the offset for parallax effect using the continuous page value
    // We want to move from left edge to right edge across all 6 screens
    // So the total movement should be limited to the extra width we have
    double maxOffset = 0.5; // Maximum offset as a fraction of screen width
    double parallaxOffset = (_currentPageValue / (_totalPages - 1)) * maxOffset;
    
    return Positioned(
      left: -parallaxOffset * MediaQuery.of(context).size.width,
      top: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width * 1.5, // Reduced from 2x to 1.5x
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/coral_diving.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // Add a dark overlay for better text readability
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ),
    );
  }



  Widget _buildOnboardingPage(int index) {
    if (index == 0) {
      return _buildLogoPage();
    } else {
      return _buildContentPage(index);
    }
  }

  Widget _buildLogoPage() {
    return Column(
      children: [
        // Main content area
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
             
                  Image.asset(
                    'images/LEARNiiT_logo.png',
                    fit: BoxFit.cover,
                  ),
                
              
              const SizedBox(height: 40),
              // Main title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    children: [
                      const TextSpan(text: 'Stay '),
                      TextSpan(
                        text: 'safe',
                        style: TextStyle(color: AppTheme.highlightColor),
                      ),
                      const TextSpan(text: '. Stay '),
                      TextSpan(
                        text: 'sharp',
                        style: TextStyle(color: AppTheme.highlightColor),
                      ),
                      const TextSpan(text: '. Stay '),
                      TextSpan(
                        text: 'certified',
                        style: TextStyle(color: AppTheme.highlightColor),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'We support diver medics and\ncommercial divers to keep their skills up\nto date in line with IMCA guidelines.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        // Bottom section with progress dots and buttons
        _buildBottomSection(),
      ],
    );
  }

  Widget _buildContentPage(int index) {
    return Column(
      children: [
        // Main content area
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              _buildHighlightedTitle(index),
              const SizedBox(height: 20),
              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'This is placeholder content for screen ${index + 1}.\nYou can replace this with your actual content.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        // Bottom section with progress dots and buttons
        _buildBottomSection(),
      ],
    );
  }

  Widget _buildHighlightedTitle(int index) {
    switch (index) {
      case 1: // Screen 2
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: [
                const TextSpan(text: 'Refresh your '),
                TextSpan(
                  text: 'competencies',
                  style: TextStyle(color: AppTheme.highlightColor),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        );
      case 2: // Screen 3
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: [
                const TextSpan(text: 'Access hundreds of '),
                TextSpan(
                  text: 'guides',
                  style: TextStyle(color: AppTheme.highlightColor),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        );
      case 3: // Screen 4
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: [
                const TextSpan(text: 'Do a '),
                TextSpan(
                  text: 'readiness check',
                  style: TextStyle(color: AppTheme.highlightColor),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        );
      case 4: // Screen 5
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: [
                const TextSpan(text: 'Ace your '),
                TextSpan(
                  text: 'workplace assessment',
                  style: TextStyle(color: AppTheme.highlightColor),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        );
      case 5: // Screen 6
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              children: [
                const TextSpan(text: 'Collate your '),
                TextSpan(
                  text: 'results',
                  style: TextStyle(color: AppTheme.highlightColor),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Screen ${index + 1} Title',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        );
    }
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPageIndex == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPageIndex == index 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Sign up or sign in to get started text
          Text(
            'Sign up or sign in to get started.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Log in button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Sign up button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SignupScreen()),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
