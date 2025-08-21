# Logit - Diving Learning Management System

A Flutter mobile application for managing diving education and training.

## Features

### Current Implementation (Phase 1 - Authentication UI)

#### Login Screen
- Email and password authentication form
- Form validation with error messages
- Password visibility toggle
- "Forgot Password" link (placeholder)
- Navigation to signup screen
- Beautiful gradient design with diving theme

#### Signup Screen
- Complete registration form with:
  - Email and password fields
  - Password confirmation
  - Profile information (First Name, Last Name, Phone)
  - User type selection (Student/Assessor)
- Form validation
- Navigation back to login screen
- Organized in sections for better UX

#### Learning Zone Dashboard
- Beautiful gradient header with rounded bottom corners
- Welcome message with highlighted username
- User statistics (competencies earned, outstanding, assessments due)
- Upcoming assessments section with filter options
- Assessment cards with due dates and categories
- In progress competencies section
- Custom floating bottom navigation bar
- Navigation between different app sections

## Design Theme

### Colors
- **Primary Gradient**: #0D2A4C to #173D6C (for large cards/containers)
- **Primary Button**: #0D2A4C
- **Background**: #F3F5F8
- **Card/Container**: #FFFFFF
- **Secondary Button**: #E8ECF0
- **Highlight**: #DFAE26

### Typography
- **Font Family**: Google Fonts - Poppins
- **Heading Styles**: Bold and semi-bold weights
- **Body Text**: Regular weight for readability

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. Clone the repository
2. Navigate to the project directory
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── theme/
│   └── app_theme.dart     # Theme configuration
├── screens/
│   ├── login_screen.dart  # Login screen
│   ├── signup_screen.dart # Signup screen
│   └── dashboard_screen.dart # Learning Zone dashboard
└── widgets/
    └── bottom_navigation.dart # Custom bottom navigation bar
```

## Dependencies

- `flutter`: Core Flutter framework
- `google_fonts`: For custom typography
- `flutter_svg`: For SVG support (ready for future use)

## Development Status

### Phase 1: Authentication UI ✅
- [x] Login screen with email/password
- [x] Signup screen with profile form
- [x] User type selection (Student/Assessor)
- [x] Form validation
- [x] Theme implementation
- [x] Navigation between screens

### Phase 2: Dashboard and Navigation ✅
- [x] Learning Zone dashboard screen
- [x] Gradient header with user stats
- [x] Upcoming assessments section
- [x] In progress competencies section
- [x] Custom bottom navigation bar
- [x] Navigation from login/signup to dashboard
- [x] Filter buttons for assessments
- [x] Assessment cards with due dates

### Next Phases (Planned)
- Phase 3: Competencies Page
- Phase 4: Guides Page
- Phase 5: Results Page
- Phase 6: Assessment System
- Phase 7: Backend Integration

## Notes

- This is currently a frontend-only implementation
- Authentication logic will be added in future phases
- The app uses placeholder functionality for login/signup actions
- All UI components follow Material Design principles with custom theming

## Contributing

This project is in active development. Please follow Flutter best practices and maintain the established design system.
